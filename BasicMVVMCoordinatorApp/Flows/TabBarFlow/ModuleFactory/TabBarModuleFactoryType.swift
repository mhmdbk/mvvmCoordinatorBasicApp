//
//  TabBarModuleFactoryType.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation

protocol TabBarModuleFactoryType: AnyObject {
    func makeHomeModule(dependencies: HomeViewModel.Dependencies) -> HomeViewController
}
