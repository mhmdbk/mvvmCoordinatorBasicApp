//
//  HomeViewModel.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-19.
//

import Foundation

class HomeViewModel {

    typealias Dependencies = HasNetworkService

    private let dependencies: Dependencies

    let pageTitleText = "home_scene.page_title_text".localized

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}
