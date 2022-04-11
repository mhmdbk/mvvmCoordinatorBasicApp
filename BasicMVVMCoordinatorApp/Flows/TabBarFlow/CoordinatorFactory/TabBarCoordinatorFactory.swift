//
//  TabBarCoordinatorFactory.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation

class TabBarCoordinatorFactory: TabBarCoordinatorFactoryType {
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

    func makeProfileCoordinator(router: RouterType,
                             dependencies: ProfileCoordinator.Dependencies)
    -> Coordinator & ProfileCoordinator {
        let profileModuleFactory = ProfileModuleFactory()
        let profileCoordinatorFactory = ProfileCoordinatorFactory()
        return ProfileCoordinator(router: router,
                                  dependencies: dependencies,
                                  moduleFactory: profileModuleFactory,
                                  coordinatorFactory: profileCoordinatorFactory)
    }

    func makeArticleCoordinator(router: RouterType,
                             dependencies: ArticleCoordinator.Dependencies)
    -> Coordinator & ArticleCoordinator {
        let articleleModuleFactory = ArticleModuleFactory()
        let articleCoordinatorFactory = ArticleCoordinatorFactory()
        return ArticleCoordinator(router: router,
                                  dependencies: dependencies,
                                  moduleFactory: articleleModuleFactory,
                                  coordinatorFactory: articleCoordinatorFactory)
    }
}
