//
//  SettingsViewModel.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/18/26.
//

import Foundation
import Combine

class SettingsViewModel: ObservableObject {
    @Published var measurementSystem: MeasurementSystem = UserDefaultsManager.shared.measurementSystem
    
    func saveMeasurementSystem() {
        UserDefaultsManager.shared.measurementSystem = measurementSystem
    }
}
