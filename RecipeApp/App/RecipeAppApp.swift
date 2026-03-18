//
//  RecipeAppApp.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/16/26.
//

import SwiftUI
import CoreData

@main
struct RecipeAppApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var authViewModel = AuthViewModel()

    init() {
        SeedDataService.seedIfNeeded(context: PersistenceController.shared.container.viewContext)
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(authViewModel)
        }
    }
}
