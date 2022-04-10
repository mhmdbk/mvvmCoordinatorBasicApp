//
//  FacebookService.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-19.
//

import FBSDKCoreKit

class FaceBookService {
    private init() { }

    static func initialise(_ application: UIApplication, _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        ApplicationDelegate.shared.application(application,
                                               didFinishLaunchingWithOptions: launchOptions)
    }
}
