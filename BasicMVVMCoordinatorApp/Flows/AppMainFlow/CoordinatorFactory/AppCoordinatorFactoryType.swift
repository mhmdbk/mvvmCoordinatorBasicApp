//
//  AppCoordinatorFactoryType.swift
//  Foodak
//
//  Created by Mounir Bittar on 4/16/20.
//  Copyright © 2020 Ideatolife. All rights reserved.
//

protocol AppCoordinatorFactoryType {
    func makeRegisterCoordinator(router: RouterType,
                                 dependencies: RegisterCoordinator.Dependencies,
                                 startingPoint: RegisterStartingPoint)
    -> Coordinator & RegisterCoordinator
}
