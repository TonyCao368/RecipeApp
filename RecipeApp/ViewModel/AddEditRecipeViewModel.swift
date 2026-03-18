//
//  AddEditRecipeViewModel.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/17/26.
//

import Foundation
import CoreData
import Combine

class AddEditRecipeViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var recipeDescription: String = ""
    @Published var instructions: String = ""
    @Published var baseServings: Int = 1
    @Published var selectedCategoryNames: Set<String> = []
    @Published var ingredients: [IngredientFormModel] = []
    @Published var newCategoryName: String = ""
    @Published var errorMessage: String = ""
    
    func load(recipe: Recipe) {
        name = recipe.name ?? ""
        recipeDescription = recipe.description ?? ""
        instructions = recipe.instructions ?? ""
        baseServings = max(Int(recipe.baseServings), 1)
        
        let categorySet = recipe.categories as? Set<Category> ?? []
        selectedCategoryNames = Set(categorySet.compactMap { $0.name })
        
        let ingredientSet = recipe.ingredients as? Set<Ingredient> ?? []
        ingredients = ingredientSet.sorted { ($0.name ?? "") < ($1.name ?? "") }.map { IngredientFormModel(id: $0.id ?? UUID(), name: $0.name ?? "", quantity: String($0.quantity), unit: $0.unit ?? "", type: $0.type ?? "count") }
    }
    
    func toggleCategory(name: String) {
        if selectedCategoryNames.contains(name) {
            selectedCategoryNames.remove(name)
        } else {
            selectedCategoryNames.insert(name)
        }
    }
    
    func addEmptyIngredient() {
        ingredients.append(IngredientFormModel(id: UUID(), name: "", quantity: "", unit: "", type: "count"))
    }
    
    func validate() -> Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Recipe name is required"
            return false
        }
        if name.count > 50 {
            errorMessage = "Recipe name must be 50 characters or less"
            return false
        }
        if recipeDescription.count > 250 {
            errorMessage = "Recipe description must be 250 characters or less"
            return false
        }
        
        if instructions.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Instructions are required"
            return false
        }
        errorMessage = ""
        return true
    }
    
    func saveRecipe(recipe: Recipe?, context: NSManagedObjectContext, allCategories: [Category]) {
        guard validate() else { return }
        
        let currentRecipe = recipe ?? Recipe(context: context)
        
        if recipe == nil {
            currentRecipe.id = UUID()
            currentRecipe.imageName = "fork.knife.circle"
            currentRecipe.isFavorite = false
        }
        
        currentRecipe.name = String(name.prefix(20))
        currentRecipe.recipeDescription = String(recipeDescription.prefix(250))
        currentRecipe.instructions = instructions
        currentRecipe.baseServings = Int16(baseServings)
        
        if let oldIngredients = currentRecipe.ingredients as? Set<Ingredient> {
            for ingredient in oldIngredients {
                context.delete(ingredient)
            }
        }
        
        currentRecipe.removeFromCategories(currentRecipe.categories ?? NSSet())
        
        for category in allCategories where selectedCategoryNames.contains(category.name ?? "") {
            currentRecipe.addToCategories(category)
        }
        
        for item in ingredients {
            guard !item.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, let quantityValue = Double(item.quantity) else {
                continue
            }
            
            let ingredient = Ingredient(context: context)
            ingredient.id = UUID()
            ingredient.name = item.name
            ingredient.quantity = quantityValue
            ingredient.unit = item.unit
            ingredient.type = item.type
            ingredient.recipe = currentRecipe
        }
        do {
            try context.save()
        } catch {
            errorMessage = "Failed to save recipe"
            print("Save error: \(error)")
        }
    }
    
    func addCategory(context: NSManagedObjectContext) {
        let trimmed = newCategoryName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        let category = Category(context: context)
        category.id = UUID()
        category.name = trimmed
        
        do {
            try context.save()
            selectedCategoryNames.insert(trimmed)
            newCategoryName = ""
        } catch {
            errorMessage = ("Failed to add category")
        }
    }
    
}
