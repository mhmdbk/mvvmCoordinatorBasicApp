//
//  TabBarCoordinatorFactoryType.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation

protocol TabBarCoordinatorFactoryType {
    func makeHomeCoordinator(router: RouterType,
                             dependencies: HomeCoordinator.Dependencies)
    -> Coordinator & HomeCoordinator

    func makeProfileCoordinator(router: RouterType,
                             dependencies: ProfileCoordinator.Dependencies)
    -> Coordinator & ProfileCoordinator

    func makeArticleCoordinator(router: RouterType,
                             dependencies: ArticleCoordinator.Dependencies)
    -> Coordinator & ArticleCoordinator
}
