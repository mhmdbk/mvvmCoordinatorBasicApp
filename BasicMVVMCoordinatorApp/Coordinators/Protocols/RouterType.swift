//
//  RouterType.swift
//  MN Atelier
//
//  Created by Mounir Bittar on 4/16/20.
//  Copyright © 2020 Ideatolife. All rights reserved.
//

import UIKit

protocol RouterType: AnyObject, Presentable {
    var navigationController: UINavigationController { get }
    var rootViewController: UIViewController? { get }
    func present(_ module: Presentable, animated: Bool)
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    func push(_ module: Presentable, animated: Bool, completion: (() -> Void)?)
    func popModule(animated: Bool)
    func setRootModule(_ module: Presentable, hideBar: Bool)
    func popToRootModule(animated: Bool)
    func popToViewController(viewController: UIViewController)
    func dismissToRootModule(animated: Bool)
}
