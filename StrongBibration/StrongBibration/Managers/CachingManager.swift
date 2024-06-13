//
//  CachingManager.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import Foundation

final class CachingManager {
    private enum Keys {
        static let isFirstAppLoad = "IsFirstAppLoad"
//        static let isAdBlocking = "IsAdBlocking"
        static let expirationDate = "ExpirationDate"
        static let isActive = "isActive"
    }

    static let shared = CachingManager()
    private let userDefaults = UserDefaults.standard

    private init() {}

    var isFirstAppLoad: Bool {
        get { return userDefaults.bool(forKey: Keys.isFirstAppLoad) }
        set { userDefaults.set(newValue, forKey: Keys.isFirstAppLoad) }
    }

//    var adBlockerState: Bool {
//        get { return userDefaults.bool(forKey: Keys.isAdBlocking) }
//        set { userDefaults.set(newValue, forKey: Keys.isAdBlocking) }
//    }

    var expirationDate: Double? {
        get {
            if userDefaults.object(forKey: Keys.expirationDate) == nil {
                return nil
            }
            return userDefaults.double(forKey: Keys.expirationDate)
        }
        set { userDefaults.set(newValue, forKey: Keys.expirationDate) }
    }

    var isSubscriptionActive: Bool {
        get {
            // Check if expiration date is present and greater than the current date
            if let expirationDate = expirationDate, expirationDate > Date().timeIntervalSince1970 {
                return true
            } else {
                // If expiration date is not present or has passed, set subscription to false
                isSubscriptionActive = false
                return false
            }
        }
        set { userDefaults.set(newValue, forKey: Keys.isActive) }
    }
}
