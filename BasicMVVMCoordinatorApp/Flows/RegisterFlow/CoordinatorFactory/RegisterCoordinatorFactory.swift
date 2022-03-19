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
        return HomeCoordinator(router: router,
                               dependencies: dependencies,
                               moduleFactory: homeModuleFactory)
    }
}
