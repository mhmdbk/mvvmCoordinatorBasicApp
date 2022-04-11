//
//  Language.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation

enum Language {
    case en
    case ar

    var appRawValue: String {
        switch self {
        case .en:
            return "en"
        case .ar:
            return "ar"
        }
    }

    init?(fromStorage language: String) {
        switch language {
        case "ar":
            self = .ar
        case "en":
            self = .en
        default:
            return nil
        }
    }
}
