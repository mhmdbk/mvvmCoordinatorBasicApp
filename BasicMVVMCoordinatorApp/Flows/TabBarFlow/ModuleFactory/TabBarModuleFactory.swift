//
//  TabBarModuleFactory.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation

class TabBarModuleFactory: TabBarModuleFactoryType {
    func makeHomeModule(dependencies: HomeViewModel.Dependencies) -> HomeViewController {
        let homeViewController = HomeViewController.loadFromStoryboard()
        homeViewController.viewModel = HomeViewModel(dependencies: dependencies)
        return homeViewController
    }
}
