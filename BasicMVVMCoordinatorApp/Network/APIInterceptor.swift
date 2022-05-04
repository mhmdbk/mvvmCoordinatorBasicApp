//
//  APIInterceptor.swift
//  SportsMax
//
//  Created by Hussein Jaber on 18/02/2021.
//

import Foundation

final class APIInterceptor {
    
    private let apiClient = APIClient()
    
    static let shared: APIInterceptor = .init()
    
    typealias CompletionHandler = (() -> Void)
    
    private var handlers: [CompletionHandler] = []
    private var isRefreshingToken = false

    
    func addFailedRequest(_ completion: @escaping CompletionHandler) {
        handlers.append(completion)
        if !isRefreshingToken {
//            refreshToken()
        }
    }
    
    private func executeAllPendingRequests()  {
        handlers.forEach({ $0() })
        flush()
    }
    
//    private func refreshToken() {
//        isRefreshingToken = true
//        ApplicationStorage.kUserShouldUpdateFollowing = false
////        apiClient.loginWithToken { [weak self] (result) in
////            guard let self = self else { return }
////            switch result {
////            case .failure(let error):
////                self.flush()
////                if case APIError.forbidden = error {
////                    UserManager.logoutUser()
////                    NotificationCenter.default.post(name: .userStatusHasBeenChanged, object: nil, userInfo: nil)
////                    NotificationCenter.default.post(name: .sessionExpiredNotificationKey, object: nil, userInfo: nil)
////                } else if case APIError.bandwidthLimitExceeded = error {
////                    UserManager.logoutUser()
////                    // NotificationCenter.default.post(name: .userStatusHasBeenChanged, object: nil, userInfo: nil)
////                    NotificationCenter.default.post(name: .bandwidthLimitExceededNotificationKey, object: nil, userInfo: nil)
////                } else {
////                    NotificationCenter.default.post(name: .oopsSomethingWentWrongNotificationKey, object: nil, userInfo: nil)
////                }
////            case .success(let response):
////                ApplicationStorage.currentUserObject = response
////                UserManager.handleUserSubscriptions(subscriptions: response.subscriptions)
////                UserManager.selectDefaultTheme(result: response)
////                UserManager.setUserDefaultSettings(result: response)
////                self.executeAllPendingRequests()
////            }
////            self.isRefreshingToken = false
////
////        }
//    }
  

    private func flush() {
        handlers = []
    }
}


