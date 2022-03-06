//
//  SpacexService.swift
//  SpaceX
//
//  Created by Jaafar Barek on 26/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

enum ServiceError: Error {
    case cannotParse
}

/// A service that knows how to perform requests for GitHub data.
class BasicNetworkService: NetworkService {
    var baseUrl = "https://api.spacexdata.com/v4/"
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}
