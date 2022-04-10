//  RegisterModuleFactory.swift
//  BasicMVVMCoordinatorApp
//  Created by MohammadBarek on 2022-03-07.

class RegisterModuleFactory: RegisterModuleFactoryType {
    func makeLoginModule(dependencies: LoginViewModel.Dependencies) -> LoginViewController {
        let loginViewController = LoginViewController.loadFromStoryboard()
        loginViewController.viewModel = LoginViewModel(dependencies: dependencies)
        return loginViewController
    }

    func makeRegisterModule(dependencies: RegisterViewModel.Dependencies) -> RegisterViewController {
        let registerViewController = RegisterViewController.loadFromStoryboard()
        registerViewController.viewModel = RegisterViewModel(dependencies: dependencies)
        return registerViewController
    }
}
