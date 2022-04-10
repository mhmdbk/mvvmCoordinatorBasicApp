//
//  UserManager.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-07.
//

import Foundation

struct UserManager {

    private init() {}

    static func logoutUser() {
        ApplicationStorage.currentUserObject = nil
        ApplicationStorage.kDeviceToken = nil
        ApplicationStorage.kUserName = ""
    }

    /// Indicates wether the a user is logged in or not
    /// device token should be userToken in realWorldApp, where the userToken should be returned from loginAPI
    static var isLoggedIn: Bool {
        ApplicationStorage.currentUserObject != nil && ApplicationStorage.kDeviceToken != nil
    }

}
