//
//  LoginResponse.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-07.
//

import Foundation

struct LoginResponse: Codable {
    let id: String?
    let name: String?
    let email: String?
    let deviceToken: String?
}
