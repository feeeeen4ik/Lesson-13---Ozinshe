//
//  AccauntModel.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 18.12.2025.
//

import Foundation

final class ProfileStorage {
    static let shared = ProfileStorage()
    
    private init() {}
    
    private let tokenKey = "accessToken"
    
    var accessToken: String {
        get {
            UserDefaults.standard.string(forKey: tokenKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: tokenKey)
        }
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
}
