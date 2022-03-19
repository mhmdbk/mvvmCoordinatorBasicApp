//
//  RegisterModuleFactory.swift
//  Foodak
//
//  Created by Batoul Issa on 1/19/21.
//  Copyright © 2021 Ideatolife. All rights reserved.
//


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
