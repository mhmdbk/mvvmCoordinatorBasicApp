//
//  AppCoordinator.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-06.
//

import Foundation

final class AppCoordinator: BaseCoordinator {
    private let dependencyProvider: DependencyProvider
    private let moduleFactory: AppModuleFactoryType

    init(router: RouterType,
         moduleFactory: AppModuleFactoryType) {
        self.dependencyProvider = DependencyProvider()
        self.moduleFactory = moduleFactory
        super.init(router: router)
    }

    override init(router: RouterType) {
        self.dependencyProvider = DependencyProvider()
        self.moduleFactory = AppModuleFactory()
        super.init(router: router)
    }

    override func start() {
        showMainModule()
    }
}

// MARK: - Private helper methods
private extension AppCoordinator {
    func showMainModule() {
        let mainViewController = moduleFactory.makeMainModule(dependencies: dependencyProvider)
        router.setRootModule(mainViewController, hideBar: false)
    }
}
