//
//  HomeViewModel.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/17/26.
//

import Foundation
import CoreData
import Combine

class HomeViewModel: ObservableObject {
    @Published var selectedCategoryNames: Set<String> = []
    @Published var isAscending: Bool = false
    
    func toggleCategory(_ categoryName: String) {
        if selectedCategoryNames.contains(categoryName){
            selectedCategoryNames.remove(categoryName)
        } else {
            selectedCategoryNames.insert(categoryName)
        }
    }
    
    func filteredRecipes(from recipes: [Recipe]) -> [Recipe] {
        let filtered: [Recipe]
        
        if selectedCategoryNames.isEmpty {
            filtered = recipes
        } else {
            filtered = recipes.filter { recipe in
                let recipeCategories = (recipe.categories as? Set<Category> ?? []).compactMap { $0.name }
                return selectedCategoryNames.allSatisfy { recipeCategories.contains($0) }
            }
        }
        
        return filtered.sorted {
            let left = $0.name ?? ""
            let right = $1.name ?? ""
            return isAscending ? left < right : left > right
        }
    }
    
    func toggleFavorite(for recipe: Recipe, context: NSManagedObjectContext) {
        recipe.isFavorite.toggle()
        
        do {
            try context.save()
        } catch {
            print("Failed to toggle favorite: \(error)")
        }
    }
}
