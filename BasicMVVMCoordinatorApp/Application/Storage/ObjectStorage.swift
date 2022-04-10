//
//  ObjectStorage.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-07.
//

import Foundation

@propertyWrapper
struct ObjectStorage<Value: Codable> {
    
    private let key: String
    private let defaultValue: Value?
    private let userDefaults = UserDefaults.standard
    
    init(key: String, defaultValue: Value? = nil) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: Value? {
        set {
            if let value = newValue {
                let data = convertToData(value)
                userDefaults.setValue(data, forKey: key)
            } else {
                userDefaults.removeObject(forKey: key)
            }
        }
        
        get {
            if let data = fetchDataFromUserdefaults() {
                return try? JSONDecoder().decode(Value.self, from: data)
            }
            return defaultValue
        }
    }
    
    private func convertToData(_ value: Value) -> Data? {
        if let data = try? JSONEncoder().encode(value) {
            return data
        }
        return nil
    }
    
    private func fetchDataFromUserdefaults() -> Data? {
        if let data = userDefaults.data(forKey: key) {
            return data
        }
        return nil
    }
}

@propertyWrapper
struct SimpleStorage<T> {

    private let key: String
    private let defaultValue: T?
    init(key: String, defaultValue: T? = nil) {
        self.key = key
        self.defaultValue = defaultValue
    }
    var wrappedValue: T? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
        get {
            UserDefaults.standard.value(forKey: key) as? T ?? defaultValue
        }
    }
}
