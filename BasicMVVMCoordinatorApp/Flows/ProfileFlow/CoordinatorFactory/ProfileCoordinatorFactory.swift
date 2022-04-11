//
//  ProfileCoordinatorFactory.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation

class ProfileCoordinatorFactory: ProfileCoordinatorFactoryType {
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
}
