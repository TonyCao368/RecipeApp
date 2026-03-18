//
//  SettingsView.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/18/26.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        Form {
            Section("Measurement System") {
                Picker("System", selection: $viewModel.measurementSystem) {
                    Text("Metric").tag(MeasurementSystem.metric)
                    Text("Imperial").tag(MeasurementSystem.imperial)
                }
                .pickerStyle(.segmented)
                .onChange(of: viewModel.measurementSystem) { _ in
                    viewModel.saveMeasurementSystem()
                }
            }
            
            Section("Account") {
                Button("Logout", role: .destructive) {
                    authViewModel.logout()
                }
            }
        }
        .navigationTitle("Settings")
    }
}
