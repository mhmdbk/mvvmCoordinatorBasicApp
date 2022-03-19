//
//  Fonts.swift
//  SpaceX
//
//  Created by Jaafar Barek on 26/03/2021.
//

import UIKit

struct Fonts {
    enum FontName {
        case font100 // Thin
        case font200 // Extra Light
        case font300 // Light
        case font400 // Regular
        case font500 // Medium
        case font600 // Semi Bold
        case font700 // Bold
        case font800 // Extra Bold
    }

    private static let defaultLatinFontName = "MuseoSans-500"

    static let latinFonts: [FontName: String] = [
        .font100: "Poppins-Thin",
        .font200: "Poppins-ExtraLight",
        .font300: "Poppins-Light",
        .font400: "Poppins-Regular",
        .font500: "Poppins-Medium",
        .font600: "Poppins-SemiBold",
        .font700: "Poppins-Bold",
        .font800: "Poppins-ExtraBold"
    ]

    static func fontName(font: FontName) -> String {
        return latinFonts[font] ?? defaultLatinFontName
    }

    static func font(name: FontName, size: CGFloat) -> UIFont {
        return Fonts.latinFont(for: name, size: size)
    }
}

// MARK: - Private helper methods
private extension Fonts {
    static func latinFont(for font: FontName, size: CGFloat) -> UIFont {
        let fontName = latinFonts[font]

        return Fonts.font(stringName: fontName, size: size)
    }

    static func font(stringName: String?, size: CGFloat) -> UIFont {
        guard let name = stringName, let font = UIFont(name: name, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }

        return font
    }
}
