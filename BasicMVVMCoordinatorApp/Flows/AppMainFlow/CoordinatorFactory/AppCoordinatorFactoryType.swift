//
//  AppCoordinatorFactoryType.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-07.
//

protocol AppCoordinatorFactoryType {
    func makeRegisterCoordinator(router: RouterType,
                                 dependencies: RegisterCoordinator.Dependencies,
                                 startingPoint: RegisterStartingPoint)
    -> Coordinator & RegisterCoordinator
    func makeHomeCoordinator(router: RouterType,
                                     dependencies: HomeCoordinator.Dependencies)
            -> Coordinator & HomeCoordinator
    func makeTabBarCoordinator(router: RouterType,
                             dependencies: TabBarCoordinator.Dependencies)
        -> Coordinator & TabBarCoordinator
}
