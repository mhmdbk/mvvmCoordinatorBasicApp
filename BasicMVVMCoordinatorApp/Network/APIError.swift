//
//  APIError.swift
//  SportsMax
//
//  Created by Hussein Jaber on 30/11/2020.
//

import Foundation

enum APIError: Error {
    case badBodyParams
    case badURLParams
    case error(Error)
    case unknown
    case jsonDecodingFailure
    case notFound
    case clientError
    case serverError
    case custom(title: String?, message: String?)
    case badUrl
    case noInternetConnection
    case tokenExpired
    case inAppFailure
    case badRquest
    case subscriptionExpired
    case forbidden
    case bandwidthLimitExceeded
}

