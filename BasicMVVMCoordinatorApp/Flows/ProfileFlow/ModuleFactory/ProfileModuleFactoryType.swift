//
//  ProfileModuleFactoryType.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation

protocol ProfileModuleFactoryType: AnyObject {
    func makeHomeModule(dependencies: HomeViewModel.Dependencies) -> HomeViewController
    func makeProfileModule(dependencies: ProfileViewModel.Dependencies) -> ProfileViewController
}
