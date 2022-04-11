//
//  ArticleViewController.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import UIKit

class ArticleViewController: UIViewController, StoryboardLoadable, Presentable {

    var viewModel: ArticleViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    override func viewDidLayoutSubviews() {
        configureViews()
    }
}

// MARK: - Private Helper Methods
extension ArticleViewController {
    private func configureViews() {
        guard let viewModel = viewModel else { return }
        let tabBarImage = UIImage(named: "tabbar_article_icon")
        tabBarItem = UITabBarItem(title: viewModel.pageTitleText,
                                  image: UIImage(named: "tabbar_article_icon"),
                                  selectedImage: tabBarImage?.withRenderingMode(
                                    .alwaysOriginal) ?? tabBarImage)
    }
}
