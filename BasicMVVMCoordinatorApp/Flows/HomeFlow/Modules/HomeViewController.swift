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
    var username: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
}

//MARK: - Helper methods
extension HomeViewController {
    private func configureViews() {
        usernameLabel.text = "Welcome to the basicMVVMAPP \(username)"
    }
}
