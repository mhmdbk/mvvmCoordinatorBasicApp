//
//  NibLoadable.swift
//  MN Atelier
//
//  Created by Mounir Bittar on 4/16/20.
//  Copyright © 2020 Ideatolife. All rights reserved.
//

import UIKit

protocol CellIdentifiable {

    static var cellIdentifier: String { get }

    static var cellNibName: String { get }
}

extension CellIdentifiable where Self: UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: Self.self)
    }

    static var cellNibName: String {
        return String(describing: Self.self)
    }
}

extension CellIdentifiable where Self: UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: Self.self)
    }

    static var cellNibName: String {
        return String(describing: Self.self)
    }
}

extension CellIdentifiable where Self: UICollectionReusableView {
    static var cellIdentifier: String {
        return String(describing: Self.self)
    }

    static var cellNibName: String {
        return String(describing: Self.self)
    }
}
