//
//  ApplicationStorage.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-07.
//

import Foundation

struct ApplicationStorage {
    
    /**
            For simple types (String, Bool, Int...) use `@SimpleStorage`
            For your custom types use `@ObjectStorage`, type must conform to `Codable`
            Do not add computed properties here, add them in their related files, for example: `isLoggedIn` should be in a User management file
     */

    private init() {}

    private enum StorageKey: String {
        case kUser
        case kDeviceToken
        case kUserName
        case kExpectedDRMTokenExpiry
        case kDRMToken
        case kTenantId
    }

    /// Current logged in user object
    @ObjectStorage(key: StorageKey.kUser.rawValue)
    static var currentUserObject: LoginResponse? {
        didSet {
            if let deviceToken = currentUserObject?.deviceToken {
                ApplicationStorage.kDeviceToken = deviceToken
            }
            if let name = currentUserObject?.name {
                ApplicationStorage.kUserName = name
            }
        }
    }

    @SimpleStorage(key: StorageKey.kUser.rawValue, defaultValue: "")
    static var kUser: String!

    @SimpleStorage(key: StorageKey.kDeviceToken.rawValue, defaultValue: "")
    static var kDeviceToken: String!

    @SimpleStorage(key: StorageKey.kUserName.rawValue, defaultValue: "")
    static var kUserName: String!

    @SimpleStorage(key: StorageKey.kExpectedDRMTokenExpiry.rawValue, defaultValue: 0)
    static var kExpectedDRMTokenExpiry: Int!

    @SimpleStorage(key: StorageKey.kDRMToken.rawValue, defaultValue: "")
    static var kDRMToken: String!

    @SimpleStorage(key: StorageKey.kTenantId.rawValue, defaultValue: 1)
    static var tenantId: Int!
    

}
