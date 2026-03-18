//
//  AuthViewModel.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/16/26.
//

import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = UserDefaultsManager.shared.isLoggedIn
    @Published var currentUsername: String = UserDefaultsManager.shared.username
    @Published var errorMessage: String = ""
    
    func login(username: String, password: String) {
        let hardcodedUsername = "Tony"
        let hardcodedPassword = "1234"
        
        if username == hardcodedUsername && password == hardcodedPassword {
            completeLogin(username: username)
            return
        }
        
        let users = UserDefaultsManager.shared.fetchUsers()
        if users.contains(where: { $0.username == username && $0.password == password }) {
            completeLogin(username: username)
            return
        }
        
        errorMessage = "Invalid username or password"
    }
    
    func register(email: String, username: String, password: String) -> Bool {
        var users = UserDefaultsManager.shared.fetchUsers()
        
        if users.contains(where: { $0.username == username }) {
            errorMessage = "User already exists"
            return false
        }
        
        let newUser = AppUser(id: UUID(), email: email, username: username, password: password)
        
        users.append(newUser)
        UserDefaultsManager.shared.saveUsers(users)
        return true
    }
    
    func logout() {
        UserDefaultsManager.shared.isLoggedIn = false
        currentUsername = ""
        isLoggedIn = false
    }
    
    func completeLogin(username: String) {
        UserDefaultsManager.shared.isLoggedIn = true
        UserDefaultsManager.shared.username = username
        currentUsername = username
        isLoggedIn = true
        errorMessage = ""
    }
    
    
}
