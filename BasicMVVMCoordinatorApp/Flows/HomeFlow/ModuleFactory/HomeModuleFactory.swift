//
//  HomeModuleFactory.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-19.
//

import Foundation

class HomeModuleFactory: HomeModuleFactoryType {
    func makeHomeModule(dependencies: HomeViewModel.Dependencies) -> HomeViewController {
        let homeViewController = HomeViewController.loadFromStoryboard()
        homeViewController.viewModel = HomeViewModel(dependencies: dependencies)
        return homeViewController
    }
}
