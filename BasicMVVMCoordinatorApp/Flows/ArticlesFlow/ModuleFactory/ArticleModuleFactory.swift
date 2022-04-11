//
//  ArticleModuleFactory.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation

class ArticleModuleFactory: ArticleModuleFactoryType {
    func makeArticleModule(dependencies: ArticleViewModel.Dependencies) -> ArticleViewController {
        let articleViewController = ArticleViewController.loadFromStoryboard()
        articleViewController.viewModel = ArticleViewModel(dependencies: dependencies)
        return articleViewController
    }
}
