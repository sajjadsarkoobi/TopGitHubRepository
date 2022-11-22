//
//  UserDefaultManager.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 12.11.2022.
//

import Foundation

final class UserDefaultManager {
    
    static let shared: UserDefaultManager = UserDefaultManager()
    
    private let defaultStorage = UserDefaults(suiteName: "group.com.sajjadsarkoobi.TopRepo")

    private init() {
        ///Singleton class needs the init to be private
    }
    
    //The keys for userDefaults
    enum UserDefaultsKeys: String {
        case showCachedData
    }
    
    ///Show Cached data
    var showCachedData: Bool {
        get {
            return getFromdefaultStorage(key: .showCachedData)
        }
        set(newValue) {
            saveTodefaultStorage(key: UserDefaultsKeys.showCachedData, val: newValue)
        }
    }
}

//MARK: - UserDefaultManager Helper functions
/// These functions will help inserting and extracting data from storage with the keys.
/// there is no need to specify the type of values as long as they are pre defined here.
extension UserDefaultManager {
    
    ///
    ///Extracting Data:
    ///
    
    ///retriving data from Default Storage as Data
    private func getFromdefaultStorage(key: UserDefaultsKeys ) -> Data? {
        if let response = defaultStorage?.object(forKey: key.rawValue ) as? Data {
            return response
        } else {
            return nil
        }
    }
    
    ///retriving data from Default Storage as String
    private func getFromdefaultStorage(key: UserDefaultsKeys ) -> String {
        if let response = defaultStorage?.value(forKey: key.rawValue ) as? String {
            return response
        } else {
            return ""
        }
    }
    
    ///retriving data from Default Storage as Int
    private func getFromdefaultStorage(key: UserDefaultsKeys ) -> Int {
        if let response = defaultStorage?.integer(forKey: key.rawValue )  {
            return response
        } else {
            return 0
        }
    }
    
    ///retriving data from Default Storage as Bool
    private func getFromdefaultStorage(key: UserDefaultsKeys ) -> Bool {
        if let response = defaultStorage?.bool(forKey: key.rawValue )  {
            return response
        } else {
            return false
        }
    }
    
    ///retriving data from Default Storage as Dictionary
    private func getFromdefaultStorage(key: UserDefaultsKeys ) -> Dictionary<String,Any> {
        if let response = defaultStorage?.dictionary(forKey: key.rawValue )  {
            return response
        } else {
            return [:]
        }
    }
    
    ///
    ///Inserting Data:
    ///
    
    /// Putting data in Default Storage as Data
    private func saveTodefaultStorage(key: UserDefaultsKeys, val: Data) {
        self.defaultStorage?.set(val, forKey: key.rawValue)
    }
    
    /// Putting data in Default Storage as String
    private func saveTodefaultStorage(key: UserDefaultsKeys, val: String) {
        self.defaultStorage?.set(val, forKey: key.rawValue)
    }
    
    /// Putting data in Default Storage as Integer
    private func saveTodefaultStorage(key: UserDefaultsKeys, val: Int) {
        self.defaultStorage?.set(val, forKey: key.rawValue)
    }
    
    /// Putting data in Default Storage as Bool
    private func saveTodefaultStorage(key: UserDefaultsKeys, val: Bool) {
        self.defaultStorage?.set(val, forKey: key.rawValue)
    }
    
    /// Putting data in Default Storage as Dictionary
    private func saveTodefaultStorage(key: UserDefaultsKeys, val: Dictionary<String,Any> ) {
        self.defaultStorage?.set(val, forKey: key.rawValue)
    }
}
