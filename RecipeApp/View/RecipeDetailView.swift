//
//  RecipeDetailView.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/17/26.
//

import SwiftUI
import CoreData

struct RecipeDetailView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    let recipe: Recipe
    
    @State var selectedServings: Int = 1
    @State var showDeleteAlert = false
    
    var sortedCategories: [Category] {
        let set = recipe.categories as? Set<Category> ?? []
        return set.sorted { ($0.name ?? "") < ($1.name ?? "") }
    }
    
    var sortedIngredients: [Ingredient] {
        let set = recipe.ingredients as? Set<Ingredient> ?? []
        return set.sorted { ($0.name ?? "") < ($1.name ?? "") }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: recipe.imageName ?? "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                HStack {
                    Text(recipe.name ?? "")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Button {
                        recipe.isFavorite.toggle()
                        try? context.save()
                    } label: {
                        Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(sortedCategories, id: \.objectID) { category in
                            Text(category.name ?? "")
                                .font(.caption)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .overlay(Capsule().stroke(Color.gray))
                        }
                    }
                }
                Text(recipe.recipeDescription ?? "")
                    .foregroundColor(.secondary)
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Ingredients")
                            .font(.headline)
                        Spacer()
                        Picker("Servings", selection: $selectedServings) {
                            ForEach(1...8, id: \.self) { value in
                                Text("\(value)").tag(value)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    ForEach(sortedIngredients, id: \.objectID) { ingredient in
                        IngredientRowView(ingredient: ingredient, selectedServings: selectedServings)
                    }
                }
                VStack(alignment: .leading, spacing: 12) {
                    Text("Instructions")
                        .font(.headline)
                    Text(recipe.instructions ?? "")
                }
            }
            .padding()
        }
        .navigationTitle("Recipe Detail")
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                NavigationLink {
                    AddEditRecipeView(recipe: recipe)
                } label: {
                    Image(systemName: "pencil")
                }
                
                Button(role: .destructive) {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .onAppear {
            selectedServings = max(Int(recipe.baseServings), 1)
        }
        .alert("Delete Recipe?", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                context.delete(recipe)
                try? context.save()
                dismiss()
            }
            Button("Cancel", role: .cancel) {
                
            }
        } message: {
            Text("This action cannot be undone.")
        }
    }
}
