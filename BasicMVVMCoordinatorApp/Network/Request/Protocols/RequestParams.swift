//
//  RequestParams.swift
//  SportsMax
//
//  Created by Hussein Jaber on 30/11/2020.
//

import Foundation

enum RequestParams {
    case body(_: [String: Any]?)
    case url(_: [String: Any]?)
    case multiPart(_: [String: String]?)
    case noParams
}
