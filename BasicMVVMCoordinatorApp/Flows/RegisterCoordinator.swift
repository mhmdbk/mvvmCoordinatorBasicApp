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
        registerViewController.onGoToHomeScreen = { [weak self] name in
            self?.runHomeFlow(name)
        }
        router.push(registerViewController, animated: true, completion: nil)
    }
    
    func showLoginScene() {
        router.push(loginViewController, animated: true, completion: nil)
    }

    func runHomeFlow(_ username: String) {
        let homeCoordinator = coordinatorFactory.makeHomeCoordinator(router: router,
                                                                     dependencies: dependencies)
        homeCoordinator.username = username
        addChildCoordinator(homeCoordinator)
        homeCoordinator.start()
    }
}
