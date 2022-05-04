//
//  UIBundle+AppVersion.swift
//  SportsMax
//
//  Created by Saud on 12/2/20.
//

import Foundation

extension Bundle {
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
}
