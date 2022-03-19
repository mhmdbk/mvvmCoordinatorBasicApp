//
//  HomeModuleFactoryType.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-19.
//

import Foundation

protocol HomeModuleFactoryType: AnyObject {
    func makeHomeModule(dependencies: HomeViewModel.Dependencies) -> HomeViewController
}
