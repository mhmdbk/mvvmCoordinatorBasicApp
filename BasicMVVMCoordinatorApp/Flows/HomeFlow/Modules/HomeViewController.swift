//
//  HomeViewController.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-19.
//

import UIKit

class HomeViewController: UIViewController, StoryboardLoadable, Presentable {

    @IBOutlet private weak var usernameLabel: UILabel!

    var viewModel: HomeViewModel!
    private let username: String = ApplicationStorage.kUserName

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
}

//MARK: - Helper methods
extension HomeViewController {
    private func configureViews() {
        guard let viewModel = viewModel else { return }

        let selectedTabBarImage = UIImage(named: "tabbar_home_icon")
        tabBarItem = UITabBarItem(title: viewModel.pageTitleText,
                                  image: UIImage(named: "tabbar_home_icon"),
                                  selectedImage: selectedTabBarImage?.withRenderingMode(
                                    .alwaysOriginal) ?? selectedTabBarImage)
        
        usernameLabel.text = "Welcome to the basicMVVMAPP \(username)"
    }
}
