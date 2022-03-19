//
//  FacebookLoginResponse.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-07.
//

import Foundation
struct FacebookLoginResponse: Decodable {
    let profileId: String
    let token: String
    let firstName: String?
    let lastName: String?

    enum CodingKeys: String, CodingKey {
        case profileId = "id"
        case token = "fbToken"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
