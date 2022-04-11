//
//  RegisterCoordinator.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-07.
//
//


enum RegisterStartingPoint {
    case login
    case register
}

class RegisterCoordinator: BaseCoordinator, RegisterCoordinatorOutput {
    typealias Dependencies = HasNetworkService

    private let dependencies: Dependencies
    private let moduleFactory: RegisterModuleFactoryType
    private let startingPoint: RegisterStartingPoint
    private let coordinatorFactory: RegisterCoordinatorFactoryType

    var finishFlow: ((RegisterStartingPoint?) -> Void)?

    private lazy var loginViewController: LoginViewController = {
        let loginViewController = moduleFactory.makeLoginModule(dependencies: dependencies)
        return loginViewController
    }()

    init(router: RouterType,
         coordinatorFactory: RegisterCoordinatorFactoryType,
         dependencies: Dependencies,
         moduleFactory: RegisterModuleFactory,
         startingPoint: RegisterStartingPoint) {
        self.dependencies = dependencies
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        self.startingPoint = startingPoint
        super.init(router: router)
    }

    override func start() {
        startingPoint == .login ? showLoginScene() : showRegisterScene()
    }
}

// MARK: - Showing modules
private extension RegisterCoordinator {
    func showRegisterScene() {
        let registerViewController = moduleFactory.makeRegisterModule(dependencies: dependencies)
        registerViewController.onGoToMainScreen = { [weak self]  in
            self?.runTabBarFlow()
        }
        router.push(registerViewController, animated: true, completion: nil)
    }
    
    func showLoginScene() {
        router.push(loginViewController, animated: true, completion: nil)
    }

    func runTabBarFlow() {
        let tabBarCoordinator = coordinatorFactory.makeTabBarCoordinator(router: router, dependencies: dependencies)
        tabBarCoordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.removeChildCoordinator(tabBarCoordinator)
        }
        addChildCoordinator(tabBarCoordinator)
        tabBarCoordinator.start()
    }
}
