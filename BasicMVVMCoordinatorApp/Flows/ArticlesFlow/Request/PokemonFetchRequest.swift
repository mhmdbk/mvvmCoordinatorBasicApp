//
//  ArticleFetchRequest.swift
//  SportsMax
//
//  Created by Saud on 12/24/20.
//

import Foundation

struct PokemonFetchRequest: Request {
    var publicPath: String {
        "pokemon"
    }
    
    var privatePath: String {
        publicPath
    }

    var offset: Int?

    var parameters: RequestParams {
        var params: [String: String] = [:]
        params[.offset] = "\(String(describing: offset))"
        return .url(params)
    }
}
