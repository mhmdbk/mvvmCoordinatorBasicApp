//
//  Presentable.swift
//  MN Atelier
//
//  Created by Mounir Bittar on 4/16/20.
//  Copyright © 2020 Ideatolife. All rights reserved.
//

import UIKit

protocol Presentable {
    func toPresent() -> UIViewController
}

extension Presentable where Self: UIViewController {
    func toPresent() -> UIViewController {
        return self
    }
}
