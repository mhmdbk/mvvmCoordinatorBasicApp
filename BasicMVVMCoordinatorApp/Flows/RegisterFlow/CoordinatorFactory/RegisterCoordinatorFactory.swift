//
//  RegisterCoordinatorFactory.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-19.
//

import Foundation

class RegisterCoordinatorFactory: RegisterCoordinatorFactoryType {
    func makeHomeCoordinator(router: RouterType,
                             dependencies: HomeCoordinator.Dependencies)
    -> Coordinator & HomeCoordinator {
        let homeModuleFactory = HomeModuleFactory()
        let homeCoordinatorFactory = HomeCoordinatorFactory()
        return HomeCoordinator(router: router,
                               dependencies: dependencies,
                               moduleFactory: homeModuleFactory,
                               coordinatorFactory: homeCoordinatorFactory)
    }

    func makeTabBarCoordinator(router: RouterType, dependencies: TabBarCoordinator.Dependencies) -> Coordinator & TabBarCoordinator {
        let tabBarModuleFactory = TabBarModuleFactory()
        let tabBarCoordinatorFactory = TabBarCoordinatorFactory()
        return TabBarCoordinator(router: router,
                                 dependencies: dependencies,
                                 moduleFactory: tabBarModuleFactory,
                                 coordinatorFactory: tabBarCoordinatorFactory)
    }
}
