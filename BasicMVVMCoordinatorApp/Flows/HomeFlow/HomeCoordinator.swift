//
//  HomeCoordinator.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-19.
//

import Foundation
class HomeCoordinator: BaseCoordinator, HomeCoordinatorOutput {
    typealias Dependencies = HasNetworkService

    private let dependencies: Dependencies
    private let moduleFactory: HomeModuleFactoryType
    private let coordinatorFactory: HomeCoordinatorFactoryType
    var finishFlow: (() -> Void)?

    private lazy var homeViewController: HomeViewController = {
        let homeViewController = moduleFactory.makeHomeModule(dependencies: dependencies)
        return homeViewController
    }()

    init(router: RouterType,
         dependencies: Dependencies,
         moduleFactory: HomeModuleFactoryType,
         coordinatorFactory: HomeCoordinatorFactoryType) {
        self.dependencies = dependencies
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router)
    }

    override func start() {
        router.setRootModule(homeViewController, hideBar: false)
    }
}

// MARK: - Showing modules
private extension HomeCoordinator {
}
