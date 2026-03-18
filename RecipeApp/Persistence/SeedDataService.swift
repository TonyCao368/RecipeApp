//
//  SeedDataService.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/16/26.
//

import CoreData

struct SeedDataService {
    static func seedIfNeeded(context: NSManagedObjectContext) {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        
        do {
            let count = try context.count(for: request)
            if count > 0 {
                return
            }
        } catch {
            print("Failed to count recipes: \(error)")
            return
        }
        
        let breakfast = Category(context: context)
        breakfast.id = UUID()
        breakfast.name = "Breakfast"
        
        let lunch = Category(context: context)
        lunch.id = UUID()
        lunch.name = "Lunch"
        
        let vegetarian = Category(context: context)
        vegetarian.id = UUID()
        vegetarian.name = "Vegetarian"
        
        let seafood = Category(context: context)
        seafood.id = UUID()
        seafood.name = "Seafood"
        
        let special = Category(context: context)
        special.id = UUID()
        special.name = "Special"
        
        createRecipe(context: context, name: "Cheese Pizza", description: "A pizza with cheese and tomato sauce", instructions: "1. Preheat oven\n2. Spread sauce\n3. Add cheese\n4.Bake", imageName: "fork.knife.circle", isFavorite: false, baseServings: 2, categories: [lunch, special], ingredients: [("Pizza Dough", 8, "oz", "weight"), ("Tomato Sauce", 4, "tbsp", "volume"), ("Mozzarella", 6, "oz", "weight")])
        
        createRecipe(context: context, name: "Avocado Toast", description: "Simple avocado toast", instructions: "1. Toast bread\n2. Mash avocado\n3. Spread and serve", imageName: "leaf.circle", isFavorite: false, baseServings: 1, categories: [breakfast, vegetarian], ingredients: [("Bread", 2, "count", "count"), ("Avocado", 1, "count", "count"), ("Olive Oil", 1, "tbsp", "volume")])
        
        createRecipe(context: context, name: "Salmon Bowl", description: "Bowl of rice with salmon", instructions: "1. Cook salmon\n2. Cook rice\n3. Assemble bowl", imageName: "fish.circle", isFavorite: false, baseServings: 2, categories: [lunch, seafood], ingredients: [("Salmon", 10, "oz", "weight"), ("Rice", 6, "oz", "weight")])
        
        do {
            try context.save()
        } catch {
            print("Failed to seed data: \(error)")
        }
    }
    
    static func createRecipe(context: NSManagedObjectContext, name: String, description: String, instructions: String, imageName: String, isFavorite: Bool, baseServings: Int16, categories: [Category], ingredients: [(String, Double, String, String)]) {
        let recipe = Recipe(context: context)
        recipe.id = UUID()
        recipe.name = name
        recipe.recipeDescription = description
        recipe.instructions = instructions
        recipe.imageName = imageName
        recipe.isFavorite = isFavorite
        recipe.baseServings = baseServings
        
        for category in categories {
            recipe.addToCategories(category)
        }
        
        for item in ingredients {
            let ingredient = Ingredient(context: context)
            ingredient.id = UUID()
            ingredient.name = item.0
            ingredient.quantity = item.1
            ingredient.unit = item.2
            ingredient.type = item.3
            ingredient.recipe = recipe
        }
        
    }
    
}
