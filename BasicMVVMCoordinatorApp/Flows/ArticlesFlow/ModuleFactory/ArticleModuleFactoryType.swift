//
//  ArticleModuleFactoryType.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation

protocol ArticleModuleFactoryType: AnyObject {
    func makeArticleModule(dependencies: ArticleViewModel.Dependencies) -> ArticleViewController
}
