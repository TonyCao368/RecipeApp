//
//  UnitConverter.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/17/26.
//

import Foundation

struct UnitConverter {
    static func convert(quantity: Double, unit: String, to system: MeasurementSystem) -> (Double, String) {
        let lowercasedUnit = unit.lowercased()
        
        switch(lowercasedUnit, system) {
        case("oz", .metric):
            return (quantity * 28.3495, "g")
        case ("tbsp", .metric):
            return (quantity * 14.7868, "mL")
        case ("g", .imperial):
            return (quantity / 28.3495, "oz")
        case ("ml", .imperial):
            return (quantity / 14.7868, "tbsp")
        default:
            return (quantity, unit)
        }
    }
    
    static func adjustedQuantity(originalQuantity: Double, baseServings: Int, selectedServings: Int) -> Double {
        guard baseServings > 0 else { return originalQuantity }
        return originalQuantity * Double(selectedServings) / Double(baseServings)
    }
}
