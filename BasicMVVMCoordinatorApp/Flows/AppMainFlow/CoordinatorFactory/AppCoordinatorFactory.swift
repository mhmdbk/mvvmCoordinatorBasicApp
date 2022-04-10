//
//  AppCoordinatorFactory.swift
//  Foodak
//
//  Created by Mounir Bittar on 4/16/20.
//  Copyright © 2020 Ideatolife. All rights reserved.
//

class AppCoordinatorFactory: AppCoordinatorFactoryType {
    func makeRegisterCoordinator(router: RouterType,
                                 dependencies: RegisterCoordinator.Dependencies,
                                 startingPoint: RegisterStartingPoint)
    -> Coordinator & RegisterCoordinator {
        let registerModuleFactory = RegisterModuleFactory()
        let registerCoordinatorFactory = RegisterCoordinatorFactory()
        return RegisterCoordinator(router: router,
                                   coordinatorFactory: registerCoordinatorFactory,
                                   dependencies: dependencies,
                                   moduleFactory: registerModuleFactory,
                                   startingPoint: startingPoint)
    }
}
