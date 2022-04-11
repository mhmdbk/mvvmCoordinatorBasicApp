//
//  TabBarCoordinator.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import UIKit

enum tabBarTitles: String {
    case HOME = "Home"
    case ARTICLES = "Articles"
    case PROFILE = "Profile"
}

class TabBarCoordinator: BaseCoordinator, TabBarCoordinatorOutput {
    typealias Dependencies = HasNetworkService

    private let dependencies: Dependencies
    private let moduleFactory: TabBarModuleFactoryType
    private let coordinatorFactory: TabBarCoordinatorFactoryType

    var finishFlow: (() -> Void)?

    private lazy var homeViewController: HomeViewController = {
        let homeViewController = moduleFactory.makeHomeModule(dependencies: dependencies)
        return homeViewController
    }()

    private lazy var tabBarController: UITabBarController = {
        let tabBarController = UITabBarController()
        let tabbarFont = Fonts.font(name: .font500, size: 10)
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.isHidden = !UserManager.isLoggedIn
        tabBarController.tabBar.backgroundColor = .black
        tabBarController.tabBar.tintColor = .cyan
        return tabBarController
    }()

    private lazy var homeCoordinator: Coordinator & HomeCoordinator = {
        let homeCoordinatorNavigationController = CustomNavigationController()
        let homeCoordinatorRouter = Router(navigationController: homeCoordinatorNavigationController)
        let homeCoordinator = coordinatorFactory.makeHomeCoordinator(router: homeCoordinatorRouter,
                                                                     dependencies: dependencies)
        homeCoordinator.finishFlow = { [weak self] in
            self?.finishFlow?()
        }
        return homeCoordinator
    }()

    private lazy var profileCoordinator: Coordinator & ProfileCoordinator = {
        let profileCoordinatorNavigationController = CustomNavigationController()
        let profileCoordinatorRouter = Router(navigationController: profileCoordinatorNavigationController)
        let profileCoordinator = coordinatorFactory.makeProfileCoordinator(router: profileCoordinatorRouter,
                                                                           dependencies: dependencies)
        profileCoordinator.finishFlow = { [weak self] in
            self?.finishFlow?()
        }
        return profileCoordinator
    }()

    private lazy var articleCoordinator: Coordinator & ArticleCoordinator = {
        let articleCoordinatorNavigationController = CustomNavigationController()
        let articleCoordinatorRouter = Router(navigationController: articleCoordinatorNavigationController)
        let articleCoordinator = coordinatorFactory.makeArticleCoordinator(router: articleCoordinatorRouter,
                                                                           dependencies: dependencies)
        articleCoordinator.finishFlow = { [weak self] in
            self?.finishFlow?()
        }
        return articleCoordinator
    }()

    init(router: RouterType,
         dependencies: Dependencies,
         moduleFactory: TabBarModuleFactoryType,
         coordinatorFactory: TabBarCoordinatorFactoryType) {
        self.dependencies = dependencies
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        super.init(router: router)
    }

    override func start() {
        configureTabBar()
        router.setRootModule(tabBarController, hideBar: false)
    }

    override func toPresent() -> UIViewController {
        return tabBarController
    }

}

// MARK: - Private Helper Methods
private extension TabBarCoordinator {
    func configureTabBar() {
        let homeCoordinatorRootViewController = homeCoordinator.toPresent()
        let articleCoordinatorRootViewController = articleCoordinator.toPresent()
        let profileCoordinatorRootViewController = profileCoordinator.toPresent()
        homeCoordinator.start()
        articleCoordinator.start()
        profileCoordinator.start()
        addTabBarItem(image: Constants.Images.home_tabbar_icon, title: tabBarTitles.HOME.rawValue, toViewController: homeCoordinatorRootViewController, tag: 0)
        addTabBarItem(image: Constants.Images.article_tabbar_icon, title: tabBarTitles.ARTICLES.rawValue, toViewController: articleCoordinatorRootViewController, tag: 1)
        addTabBarItem(image: Constants.Images.profile_tabbar_icon, title: tabBarTitles.PROFILE.rawValue, toViewController: profileCoordinatorRootViewController, tag: 2)
        tabBarController.setViewControllers([homeCoordinatorRootViewController,
                                             articleCoordinatorRootViewController,
                                             profileCoordinatorRootViewController],
                                            animated: false)
    }

    func addTabBarItem(image: UIImage, title: String, toViewController: UIViewController, tag: Int) {
        let tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        toViewController.tabBarItem = tabBarItem
    }
}

