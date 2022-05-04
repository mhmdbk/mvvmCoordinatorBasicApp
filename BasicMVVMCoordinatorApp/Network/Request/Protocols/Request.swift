//
//  Request.swift
//  SportsMax
//
//  Created by Hussein Jaber on 30/11/2020.
//

import Foundation
import UIKit

protocol Request {
    var publicPath: String { get }
    var privatePath: String { get }
    var method: HTTPMethod_ { get  }
    var headers: [String: Any]? { get }
    var parameters: RequestParams { get }
    var responseType: ResponseType { get }
}

extension Request {
    var headers: [String: Any]? {
        nil
    }
    
    var method: HTTPMethod_ {
        .get
    }
    
    
    var parameters: RequestParams {
        .noParams
    }
    
    var responseType: ResponseType {
        .json
    }
}

extension Request {
    var tenantId: Int {
        ApplicationStorage.tenantId
    }
    
    var videoFormat: String {
        "hls"
    }
    
    var fairPlayVideoFormat: String {
        "hlsFP"
    }

}

extension Request {
    var deviceType: String {
        if UIDevice.isRunningOnIpad {
            return "TABLET"
        }
        return "MOBILE"
    }
}


