//
//  RegisterModuleFactoryType.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-07.
//
//

protocol RegisterModuleFactoryType: AnyObject {
    func makeLoginModule(dependencies: LoginViewModel.Dependencies) -> LoginViewController
    func makeRegisterModule(dependencies: RegisterViewModel.Dependencies) -> RegisterViewController
}
