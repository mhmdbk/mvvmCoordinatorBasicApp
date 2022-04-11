//
//  String+Localized.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func localized(with arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }

    func localizedWithLocale(with arguments: CVarArg...) -> String {
        return String(format: self.localized, locale: Locale.current, arguments: arguments)
    }

    func localizedNumber() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: Language.en.appRawValue)
        return formatter.number(from: self)?.stringValue ?? ""
    }
}
