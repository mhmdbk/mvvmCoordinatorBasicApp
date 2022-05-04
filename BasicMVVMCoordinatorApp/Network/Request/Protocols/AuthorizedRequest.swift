//
//  AuthorizedRequest.swift
//  SportsMax
//
//  Created by Hussein Jaber on 14/12/2020.
//

import Foundation

protocol AuthorizedRequest: Request { }

extension AuthorizedRequest {
    var headers: [String : Any]? {
        nil
    }
}
