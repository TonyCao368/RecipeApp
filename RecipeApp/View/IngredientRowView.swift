//
//  IngredientRowView.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/17/26.
//

import SwiftUI

struct IngredientRowView: View {
    let ingredient: Ingredient
    let selectedServings: Int
    
    var displayText: String {
        let baseServings = Int(ingredient.recipe?.baseServings ?? 1)
        let adjusted = UnitConverter.adjustedQuantity(originalQuantity: ingredient.quantity, baseServings: baseServings, selectedServings: selectedServings)
        
        let measurementSystem = UserDefaultsManager.shared.measurementSystem
        let converted = UnitConverter.convert(quantity: adjusted, unit: ingredient.unit ?? "", to: measurementSystem)
        return "\(ingredient.name ?? "") - \(String(format: "%.1f", converted.0)) \(converted.1)"
    }
    
    var body: some View {
        Text(displayText)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
