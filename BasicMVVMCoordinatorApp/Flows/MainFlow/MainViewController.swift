//
//  MainViewController.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-06.
//

import UIKit

class MainViewController: UIViewController, StoryboardLoadable, Presentable {

    var viewModel: MainViewModel!

    var onGoToLoginRegister: ((RegisterStartingPoint) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        assert(viewModel != nil, "ViewModel cannot be nil")
        configureViews()
    }
}

// MARK: - Private Helper Methods
private extension MainViewController {
    func configureViews() {
    }
}

// MARK: - IBActions
extension MainViewController {
    @IBAction func goToRegisterOnTapped(_ sender: Any) {
        onGoToLoginRegister?(.register)
    }

    @IBAction func onLoginPressed(_ sender: Any) {
        onGoToLoginRegister?(.login)
    }
}
