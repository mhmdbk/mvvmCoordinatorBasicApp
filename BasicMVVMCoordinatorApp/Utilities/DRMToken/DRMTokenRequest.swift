//
//  DRMTokenRequest.swift
//  SportsMax
//
//  Created by Hussein Jaber on 16/02/2021.
//

import Foundation

struct RefreshDRMTokenRequest: Request {
    
    var privatePath: String {
        "/sb/drmtoken/refresh"
    }
    
    var publicPath: String {
        privatePath
    }
    
    var method: HTTPMethod_ {
        .post
    }

}

protocol DRMTokenAPIClient {
    func refreshToken(_ completion: @escaping (Result<Bool, APIError>) -> Void)
}

extension APIClient: DRMTokenAPIClient {
    func refreshToken(_ completion: @escaping (Result<Bool, APIError>) -> Void) {
        let request = RefreshDRMTokenRequest()
        genericRequest(forRequest: request, forType: Bool.self, result: completion)
    }
}
