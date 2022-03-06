//
//  StoryboardLoadable.swift
//  MN Atelier
//
//  Created by Mounir Bittar on 4/16/20.
//  Copyright © 2020 Ideatolife. All rights reserved.
//

import UIKit

// swiftlint:disable force_cast
protocol StoryboardLoadable {

    static var storyboardId: String { get }

    static var storyboardControllerId: String { get }
}

extension StoryboardLoadable where Self: UIViewController {
    static var storyboardId: String {
        return String(describing: Self.self)
    }

    static var storyboardControllerId: String {
        return String(describing: Self.self)
    }

    static func loadFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: Self.storyboardId, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Self.storyboardControllerId) as! Self
    }
}
