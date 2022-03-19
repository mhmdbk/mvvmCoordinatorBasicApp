//
//  RegisterViewModel.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-07.
//

import Foundation
import FBSDKLoginKit

class RegisterViewModel {

    typealias Dependencies = HasNetworkService

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

}
//MARK: - Network Calls
extension RegisterViewModel {
    func logInFacebookForReadPermissions(_ callBack:@escaping (FacebookLoginResponse?, Error?) -> Void) {
        let fbManager = LoginManager()
        let topMostController = UIApplication.topViewController()
        
        AccessToken.current = nil
        fbManager.logIn(permissions: ["public_profile"],
                        from: topMostController) { (result: LoginManagerLoginResult?, error: Error?) in
            
            guard error == nil else {
                print(error)
                callBack(nil, error)
                return
            }
            
            guard let fbResult = result else {
                callBack(nil, error)
                return
            }
            
            guard !fbResult.isCancelled && fbResult.grantedPermissions.contains("public_profile") else {
                callBack(nil, error)
                return
            }
            
            let graphPath = "me"
            let graphParams = ["fields": "id, email, name, first_name, last_name"]
            let fbRequest = GraphRequest(graphPath: graphPath, parameters: graphParams)
            _ = fbRequest.start { _, result, error in
                
                var error = error
                var fbResponse = result as? [String: AnyObject]
                
                if fbResponse == nil {
                }
                
                let fbToken = AccessToken.current?.tokenString ?? ""
                fbResponse?["fbToken"] = fbToken as AnyObject
                if let data = fbResponse?.data {
                    do {
                        let user = try JSONDecoder().decode(FacebookLoginResponse.self, from: data)
                        callBack(user, error)
                    } catch {
                        callBack(nil, error)
                    }
                } else { callBack(nil, error) }
            }
        }
    }
}
