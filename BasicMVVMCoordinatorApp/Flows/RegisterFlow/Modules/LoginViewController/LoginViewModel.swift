//
//  LoginViewModel.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-07.
//

import Foundation

class LoginViewModel {

    typealias Dependencies = HasNetworkService

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

}
