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
    private let coordinatorFactory: AppCoordinatorFactoryType

    init(router: RouterType,
         coordinatorFactory: AppCoordinatorFactoryType,
         moduleFactory: AppModuleFactoryType) {
        self.dependencyProvider = DependencyProvider()
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router)
    }

    override init(router: RouterType) {
        self.dependencyProvider = DependencyProvider()
        self.moduleFactory = AppModuleFactory()
        self.coordinatorFactory = AppCoordinatorFactory()
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
        mainViewController.onGoToLoginRegister = { [weak self] registeringStartingPoint in
            self?.runLoginRegisterFlow(startPoint: registeringStartingPoint)
        }
        router.setRootModule(mainViewController, hideBar: false)
    }

    func runLoginRegisterFlow(startPoint: RegisterStartingPoint) {
        let registerCoordinator = coordinatorFactory.makeRegisterCoordinator(router: router,
                                                                             dependencies: dependencyProvider,
                                                                             startingPoint: startPoint)
//        registerCoordinator.finishFlow = { [weak self, weak registerCoordinator] startingPoint in
//            guard let self = self else { return }
//            self.removeChildCoordinator(registerCoordinator)
//            if startingPoint == .login {
//                return
//            }
//        }
        addChildCoordinator(registerCoordinator)
        registerCoordinator.start()
    }
}
