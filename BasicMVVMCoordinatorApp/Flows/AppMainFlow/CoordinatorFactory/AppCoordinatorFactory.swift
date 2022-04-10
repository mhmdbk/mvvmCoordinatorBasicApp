//
//  AppCoordinatorFactory.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-07.
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

    func makeHomeCoordinator(router: RouterType,
                                    dependencies: HomeCoordinator.Dependencies)
           -> Coordinator & HomeCoordinator {
               let homeModuleFactory = HomeModuleFactory()
               return HomeCoordinator(router: router,
                                      dependencies: dependencies,
                                      moduleFactory: homeModuleFactory)
           }
}
