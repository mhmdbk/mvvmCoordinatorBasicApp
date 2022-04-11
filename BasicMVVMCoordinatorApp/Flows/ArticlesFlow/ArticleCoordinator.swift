//
//  ArticleCoordinator.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation
class ArticleCoordinator: BaseCoordinator, ArticleCoordinatorOutput {
    typealias Dependencies = HasNetworkService

    private let dependencies: Dependencies
    private let moduleFactory: ArticleModuleFactoryType
    private let coordinatorFactory: ArticleCoordinatorFactoryType
    var finishFlow: (() -> Void)?

    private lazy var articleViewController: ArticleViewController = {
        let articleViewController = moduleFactory.makeArticleModule(dependencies: dependencies)
        return articleViewController
    }()

    init(router: RouterType,
         dependencies: Dependencies,
         moduleFactory: ArticleModuleFactoryType,
         coordinatorFactory: ArticleCoordinatorFactoryType) {
        self.dependencies = dependencies
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router)
    }

    override func start() {
        router.setRootModule(articleViewController, hideBar: false)
    }
}

// MARK: - Showing modules
private extension ArticleCoordinator {
}
