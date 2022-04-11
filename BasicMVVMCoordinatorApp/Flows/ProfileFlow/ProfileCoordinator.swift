//
//  ProfileCoordinator.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation
class ProfileCoordinator: BaseCoordinator, ProfileCoordinatorOutput {
    typealias Dependencies = HasNetworkService

    private let dependencies: Dependencies
    private let moduleFactory: ProfileModuleFactoryType
    private let coordinatorFactory: ProfileCoordinatorFactoryType
    var finishFlow: (() -> Void)?

    private lazy var profileViewController: ProfileViewController = {
        let profileViewController = moduleFactory.makeProfileModule(dependencies: dependencies)
        return profileViewController
    }()

    init(router: RouterType,
         dependencies: Dependencies,
         moduleFactory: ProfileModuleFactoryType,
         coordinatorFactory: ProfileCoordinatorFactoryType) {
        self.dependencies = dependencies
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router)
    }

    override func start() {
        router.setRootModule(profileViewController, hideBar: false)
    }
}

// MARK: - Showing modules
private extension ProfileCoordinator {
}
