//
//  RegisterCoordinatorFactoryType.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-19.
//

import Foundation

protocol RegisterCoordinatorFactoryType {
    func makeHomeCoordinator(router: RouterType,
                             dependencies: HomeCoordinator.Dependencies)
    -> Coordinator & HomeCoordinator

    func makeTabBarCoordinator(router: RouterType,
                             dependencies: TabBarCoordinator.Dependencies)
        -> Coordinator & TabBarCoordinator
}
