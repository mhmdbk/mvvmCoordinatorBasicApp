//
//  SceneDelegate.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-06.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var appCoordinator: Coordinator = {
        let appNavigationController: UINavigationController = CustomNavigationController()
        let router = Router(navigationController: appNavigationController)
        return AppCoordinator(router: router)
    }()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        window.rootViewController = appCoordinator.toPresent()
        window.backgroundColor = .white
        self.window = window
        window.makeKeyAndVisible()
        appCoordinator.start()
    }

}
