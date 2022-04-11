//
//  ProfileModuleFactory.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation

class ProfileModuleFactory: ProfileModuleFactoryType {
    func makeHomeModule(dependencies: HomeViewModel.Dependencies) -> HomeViewController {
        let homeViewController = HomeViewController.loadFromStoryboard()
        homeViewController.viewModel = HomeViewModel(dependencies: dependencies)
        return homeViewController
    }

    func makeProfileModule(dependencies: ProfileViewModel.Dependencies) -> ProfileViewController {
        let profileViewController = ProfileViewController.loadFromStoryboard()
        profileViewController.viewModel = ProfileViewModel(dependencies: dependencies)
        return profileViewController
    }
}
