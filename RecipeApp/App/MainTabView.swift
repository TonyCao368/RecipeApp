//
//  MainTabView.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/16/26.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem{
                Label("Home", systemImage: "house.fill")
            }
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }
    }
}

#Preview {
    MainTabView()
}
