//
//  IngredientFormModel.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/17/26.
//

import Foundation

struct IngredientFormModel: Identifiable {
    let id: UUID
    var name: String
    var quantity: String
    var unit: String
    var type: String
}
