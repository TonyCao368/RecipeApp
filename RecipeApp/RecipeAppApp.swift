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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
