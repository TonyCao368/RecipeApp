//
//  UserDefaultsManager.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/16/26.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    init() {
        
    }
    
    let isLoggedInKey = "isLoggedIn"
    let usernameKey = "loggedInUsername"
    let measurementSystemKey = "measurementSystem"
    let usersKey = "registeredUsers"
    
    var isLoggedIn: Bool {
        get {
            UserDefaults.standard.bool(forKey: isLoggedInKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isLoggedInKey)
        }
    }
    
    var username: String {
        get {
            UserDefaults.standard.string(forKey: usernameKey) ?? "Unknown User"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: usernameKey)
        }
    }
    
    var measurementSystem: MeasurementSystem {
        get {
            let rawValue = UserDefaults.standard.string(forKey: measurementSystemKey) ?? MeasurementSystem.metric.rawValue
            return MeasurementSystem(rawValue: rawValue) ?? .metric
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: measurementSystemKey)
        }
    }
    
    func logout() {
        isLoggedIn = false
        username = ""
    }
    
    func saveUsers(_ users: [AppUser]) {
        do {
            let data = try JSONEncoder().encode(users)
            UserDefaults.standard.set(data, forKey: usersKey)
        } catch {
            print("Failed to save users: \(error)")
        }
    }
    
    func fetchUsers() -> [AppUser] {
        guard let data = UserDefaults.standard.data(forKey: usersKey) else {
            return []
        }
        
        do {
            return try JSONDecoder().decode([AppUser].self, from: data)
        } catch {
            print("Failed to fetch users: \(error)")
            return []
        }
    }
}
