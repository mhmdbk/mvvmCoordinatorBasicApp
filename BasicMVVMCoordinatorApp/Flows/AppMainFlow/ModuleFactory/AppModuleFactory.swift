//
//  AppModuleFactory.swift
//  MN Atelier
//
//  Created by Mounir Bittar on 4/16/20.
//  Copyright © 2020 Ideatolife. All rights reserved.
//

import Foundation

final class AppModuleFactory: AppModuleFactoryType {

    func makeMainModule(dependencies: MainViewModel.Dependencies) -> MainViewController {
        let homeViewController = MainViewController.loadFromStoryboard()
        homeViewController.viewModel = MainViewModel(dependencies: dependencies)
        return homeViewController
    }
}
