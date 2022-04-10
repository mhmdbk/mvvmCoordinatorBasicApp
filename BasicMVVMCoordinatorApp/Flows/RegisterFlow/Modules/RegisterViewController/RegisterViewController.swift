//
//  RegisterViewController.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-07.
//

import UIKit
import GoogleSignIn
import AuthenticationServices

class RegisterViewController: UIViewController, StoryboardLoadable, Presentable {

    var viewModel: RegisterViewModel!
    var onGoToHomeScreen: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        assert(viewModel != nil, "ViewModel cannot be nil")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - private helper methods
extension RegisterViewController {
    // here create api to login, and go the desired screen!
    func login(_ name: String,
               _ email: String,
               _ profileId: String,
               _ token: String) {
        //        LoaderHUD.showHUD(in: self)
        //        viewModel.login(profileId, token, socialType, email, name) { [weak self] success, isUserFound, error in
        //            guard let self = self else { return }
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        //                LoaderHUD.hideHUD(in: self)
        //                guard success else {
        //                    self.showAlert(withTitle: self.viewModel.alertTitle,
        //                                   message: error?.localizedDescription)
        //                    return
        //                }
        //                guard isUserFound else {
        //                    self.onRegister?(profileId, email, name, socialType)
        //                    return
        //                }
        //                self.viewModel.addLoginEvent(socialType)
        ApplicationStorage.currentUserObject = LoginResponse(id: "\(profileId)", name: name, email: email, deviceToken: token)
        self.onGoToHomeScreen?(name)
        //            }
        //        }
    }
}
// MARK: - IBActions
extension RegisterViewController {
    @IBAction func onFacebookTapped(_ sender: Any) {
        self.view.isUserInteractionEnabled = false
        viewModel.logInFacebookForReadPermissions { [weak self] (fbResponse: FacebookLoginResponse?, error: Error?) in
            self?.view.isUserInteractionEnabled = true
            guard error == nil, let user = fbResponse else {
                #if DEBUG
                print("\(error?.localizedDescription ?? "")")
                #endif
                return
            }
            let name = (user.firstName ?? "") + " " + (user.lastName ?? "")
            self?.login(name, "", user.profileId, user.token)
        }
    }

    @IBAction func onGoogleTapped(_ sender: Any) {
        let signInConfig = GoogleSignInService.configureGID()
        GIDSignIn.sharedInstance.signIn(
           with: signInConfig,
           presenting: self
       ) { user, error in
           guard error == nil else { return }
           guard let user = user else { return }

            if let error = error {
                #if DEBUG
                print("\(error.localizedDescription)")
                #endif
                return
            }
            let familyName = user.profile?.familyName ?? ""
            let givenName = user.profile?.givenName ?? "" + " " + familyName
            guard let token = user.authentication.idToken else { return } // Safe to send to the server
            guard let email = user.profile?.email else { return }
            guard let id = user.userID else { return }
            self.login(givenName, email, id, token)
        }
    }

    @IBAction func onAppleTapped(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let request = ASAuthorizationAppleIDProvider().createRequest()
            request.requestedScopes = [.fullName, .email]
            let controller = ASAuthorizationController(authorizationRequests: [request])

            controller.delegate = self
            controller.presentationContextProvider = self
            controller.performRequests()
        } else {
//            self.showSnackBar(text: viewModel.updateiOSAlertText)
        }
    }
}

// MARK: ASAuthorizationControllerDelegate
@available(iOS 13.0, *)
extension RegisterViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            var givenName = ""
            var familyName = ""
            let email = appleIDCredential.email ?? ""
            if let name = appleIDCredential.fullName {
                givenName = name.givenName ?? ""
                familyName = name.familyName ?? ""
            }

            let name = givenName + " " + familyName
            login(name, email, userIdentifier, "")
        default:
            break
        }
    }
}

@available(iOS 13.0, *)
extension RegisterViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
           return self.view.window!
    }
}
