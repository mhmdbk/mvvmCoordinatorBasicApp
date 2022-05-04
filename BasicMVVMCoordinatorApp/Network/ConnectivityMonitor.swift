//
//  ConnectivityMonitor.swift
//  SportsMax
//
//  Created by Hussein Jaber on 17/02/2021.
//

import Network
import RxCocoa
/*
    This is a new, high-level way of monitoring connectivity instead of the low level-C approach in Reachability. Unfortunately, its only available in iOS 12+. I'm keeping this here for future references though
 */

@available(iOS 12.0, *)
final class ConnectivityMonitor {
    static let shared = ConnectivityMonitor()
    
    enum ConnectionState {
        case online
        case offline
    }
    
    let stateUpdater: PublishRelay<ConnectionState> = .init()
    
    private let monitor: NWPathMonitor
    
    private var currentStatus: NWPath.Status {
        monitor.currentPath.status
    }
    
    init() {
        monitor = .init()
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.stateUpdater.accept(.online)
            } else {
                self?.stateUpdater.accept(.offline)
            }
        }
    }
}

