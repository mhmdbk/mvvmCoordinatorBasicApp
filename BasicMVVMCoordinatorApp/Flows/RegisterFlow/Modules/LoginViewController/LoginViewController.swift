//
//  LoginViewController.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-07.
//

import UIKit

class LoginViewController: UIViewController, StoryboardLoadable, Presentable {

    var viewModel: LoginViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        assert(viewModel != nil, "ViewModel cannot be nil")
    }
}
