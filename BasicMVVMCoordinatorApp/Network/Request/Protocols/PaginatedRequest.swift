//
//  PaginatedRequest.swift
//  SportsMax
//
//  Created by Hussein Jaber on 01/12/2020.
//

import Foundation

protocol PaginatedRequest: Request {
    var page: Int? { get set }
    var size: Int? { get set }
}
