//
//  AppUser.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/16/26.
//

import Foundation

struct AppUser: Codable, Identifiable {
    let id: UUID
    let email: String
    let username: String
    let password: String
}
