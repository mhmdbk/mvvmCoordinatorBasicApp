//
//  DRMTokenManager.swift
//  SportsMax
//
//  Created by Hussein Jaber on 16/02/2021.
//

import Foundation

enum APIKeys: String {
    case theme
    case offset
}

extension Dictionary where Key == String {
  
    subscript(jsonKey: APIKeys) -> Value? {
        get {
            return self[jsonKey.rawValue]
        }
        set {
            self[jsonKey.rawValue] = newValue
        }
    }
    
}

final class DRMTokenManager {
    private var timer: Timer?
    private (set) var drmToken: DRMTokenParser.DRMToken?
    private (set) var drmTokenString: String?
    private let apiClient: DRMTokenAPIClient = APIClient()
    
    static let shared: DRMTokenManager = .init()
    private var isRequestingDRMToken: Bool = false

    private init() {
       // monitorUserStatus()
        monitorTokenUpdates()
    }
    
    deinit {
        printD("Did deinit \(self)")
        timer?.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
    
    func setNewToken(drmToken: DRMTokenParser.DRMToken) {
        self.drmToken = drmToken
        self.isRequestingDRMToken = false
        setTimerToRefreshTimer()
    }
    
    private func monitorTokenUpdates() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(requestNewDRMToken),
                                               name: NSNotification.Name(rawValue: "requestNewDRMToken"),
                                               object: nil)
    }
    
    @objc
    private func checkIfTimerShouldBeInvalidated() {
        if !UserManager.isLoggedIn {
            timer?.invalidate()
        }
    }

    @objc
    func requestNewDRMToken(_ notification: NSNotification) {
        printD("MZ - DRM TOKEN - Requesting new DRM Token")
        self.performRefreshToken()
    }
    
    func invalidateTimer() {
        if !UserManager.isLoggedIn {
            timer?.invalidate()
            self.isRequestingDRMToken = false
            printD("MZ - DRM TOKEN - Timer Invalidated")
        }
    }
    
    func setNewToken(drmTokenString: String) {
        self.drmTokenString = drmTokenString
        self.isRequestingDRMToken = false
        let parsedToken = DRMTokenParser(drmToken: drmTokenString)
        if let token = parsedToken.token {
            setNewToken(drmToken: token)
        }
    }

    private func setTimerToRefreshTimer() {
        guard let expiryTimeInterval = drmToken?.exp else { return }
        let expectedRefreshTime = Int(expiryTimeInterval - 60)
        ApplicationStorage.kExpectedDRMTokenExpiry = expectedRefreshTime
        ApplicationStorage.kDRMToken = self.drmTokenString
        let currentDate = Date().timeIntervalSince1970
        let difference = expiryTimeInterval - currentDate
        let timeInterval = difference - 60
        timer?.invalidate()
        timer = nil
        if timeInterval > 0 {
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.refreshToken), userInfo: nil, repeats: true)
            printD("MZ - DRM TOKEN -      current date:      \(currentDate)")
            printD("MZ - DRM TOKEN -      expiry  date:      \(expectedRefreshTime)")
            printD("MZ - DRM TOKEN - exp time interval:      \(expiryTimeInterval)")
            printD("MZ - DRM TOKEN -  refresh time interval: \(timeInterval)")
            printD("MZ - DRM TOKEN - Timer set to refresh each \(timeInterval) seconds -> \(timeInterval / 60) minutes")
            
            timer?.tolerance = 0.1
            RunLoop.main.add(timer!, forMode: .common)
        } else {
            printD("MZ - DRM TOKEN - Interval negative.. no timer to fire")
        }
    }

    @objc
    private func refreshToken() {
        printD("MZ - DRM TOKEN - TOKEN INVOKED")
        self.performRefreshToken()
    }

    private func performRefreshToken() {
        if !isRequestingDRMToken {
            self.isRequestingDRMToken = true
            apiClient.refreshToken() { (result) in
                self.isRequestingDRMToken = false
                switch result {
                case .failure(let error):
                    printD("MZ - DRM TOKEN - Failed to obtain new drm token with error: \(error)")
                case .success:
                    printD("MZ - DRM TOKEN - Refreshed DRM token")
                }
            }
        }
    }
    
    private func getCurrentDate() {
        // get the current date and time
        let currentDateTime = Date()

        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long

        // get the date time String from the date object
        let current = formatter.string(from: currentDateTime) // October 8, 2016 at 10:48:53 PM
        printD("MZ - DRM TOKEN - Current Date: \(current)")
    }
}
