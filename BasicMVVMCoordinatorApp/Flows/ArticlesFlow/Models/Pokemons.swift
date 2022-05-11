//
//  Pokemons.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-05-04.
//

import Foundation

struct Pokemons: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Results]?
}
