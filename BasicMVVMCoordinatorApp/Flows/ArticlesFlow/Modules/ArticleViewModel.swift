//
//  ArticleViewModel.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation

class ArticleViewModel {

    typealias Dependencies = HasNetworkService

    private let dependencies: Dependencies

    let pageTitleText = "article_scene.page_title_text".localized

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}
