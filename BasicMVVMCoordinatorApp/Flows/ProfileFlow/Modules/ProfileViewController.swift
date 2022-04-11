//
//  ProfileViewController.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import UIKit

class ProfileViewController: UIViewController, StoryboardLoadable, Presentable {

    var viewModel: ProfileViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
}

// MARK: - Private Helper Methods
extension ProfileViewController {
    private func configureViews() {
        guard let viewModel = viewModel else { return }
        let tabBarImage = #imageLiteral(resourceName: "tabbar_profile_icon")
        tabBarItem = UITabBarItem(title: viewModel.pageTitleText,
                                  image: UIImage(named: "tabbar_profile_icon"),
                                  selectedImage: tabBarImage.withRenderingMode(
                                    .alwaysOriginal))
    }
}
