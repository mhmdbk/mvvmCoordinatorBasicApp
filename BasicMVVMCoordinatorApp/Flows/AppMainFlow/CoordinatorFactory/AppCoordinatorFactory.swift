//
//  AppCoordinatorFactory.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-07.
//

class AppCoordinatorFactory: AppCoordinatorFactoryType {
    func makeTabBarCoordinator(router: RouterType, dependencies: TabBarCoordinator.Dependencies) -> Coordinator & TabBarCoordinator {
        let tabBarModuleFactory = TabBarModuleFactory()
        let tabBarCoordinatorFactory = TabBarCoordinatorFactory()
        return TabBarCoordinator(router: router,
                                 dependencies: dependencies,
                                 moduleFactory: tabBarModuleFactory,
                                 coordinatorFactory: tabBarCoordinatorFactory)
    }
    
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
               let homeCoordinatorFactory = HomeCoordinatorFactory()
               return HomeCoordinator(router: router,
                                      dependencies: dependencies,
                                      moduleFactory: homeModuleFactory,
                                      coordinatorFactory: homeCoordinatorFactory)
           }
}
