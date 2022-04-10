//
//  NetworkService.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-06.
//

import Foundation

protocol NetworkService: class {
    var baseUrl: String { get set }
}
