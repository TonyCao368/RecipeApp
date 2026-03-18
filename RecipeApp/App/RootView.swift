//
//  RootView.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/16/26.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        if authViewModel.isLoggedIn {
            MainTabView()
        } else {
            NavigationStack {
                LoginView()
            }
        }
    }
}

#Preview {
    RootView()
}
