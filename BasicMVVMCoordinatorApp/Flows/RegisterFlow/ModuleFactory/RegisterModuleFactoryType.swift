//
//  RegisterModuleFactoryType.swift
//  Foodak
//
//  Created by Batoul Issa on 1/19/21.
//  Copyright © 2021 Ideatolife. All rights reserved.
//

protocol RegisterModuleFactoryType: AnyObject {
    func makeLoginModule(dependencies: LoginViewModel.Dependencies) -> LoginViewController
    func makeRegisterModule(dependencies: RegisterViewModel.Dependencies) -> RegisterViewController
}
