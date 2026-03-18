//
//  AddEditRecipeView.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/17/26.
//

import SwiftUI

struct AddEditRecipeView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    let recipe: Recipe?
    
    @StateObject var viewModel = AddEditRecipeViewModel()
    @State var showAddCategoryField = false
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)], animation: .default)
    
    var categories: FetchedResults<Category>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(recipe == nil ? "Add Recipe" : "Edit Recipe")
                    .font(.largeTitle)
                    .bold()
                
                VStack(alignment: .leading) {
                    Text("Recipe Name")
                    TextField("Enter recipe name", text: $viewModel.name)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    Text("\(viewModel.name.count)/20")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                VStack(alignment: .leading) {
                    Text("Description")
                    TextEditor(text: $viewModel.recipeDescription)
                        .frame(height: 120)
                        .padding(4)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    Text("\(viewModel.recipeDescription.count)/250")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text("Base Servings")
                    
                    Stepper(value: $viewModel.baseServings, in: 1...12) {
                        Text("\(viewModel.baseServings)")
                    }
                }
                VStack {
                    Text("Categories")
                    
                    FlexibleCategoryList(categories: Array(categories), selectedNames: viewModel.selectedCategoryNames) { name in viewModel.toggleCategory(name: name) }
                    
                    Button(showAddCategoryField ? "Hide New Category" : "Add New Category") {
                        showAddCategoryField.toggle()
                    }
                    
                    if showAddCategoryField {
                        HStack {
                            TextField("New category", text: $viewModel.newCategoryName)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                            Button("Add") {
                                viewModel.addCategory(context: context)
                            }
                        }
                    }
                }
                
                VStack {
                    Text("Ingredients")
                        .font(.headline)
                    ForEach($viewModel.ingredients) { $ingredient in
                        VStack(spacing: 10) {
                            TextField("Ingredient name", text: $ingredient.name)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                            
                            TextField("Quantity", text: $ingredient.quantity)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .keyboardType(.decimalPad)
                            
                            TextField("Unit (oz, tbsp, g, mL, count)", text: $ingredient.unit)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                            
                            TextField("Type (weight, volume, count)", text: $ingredient.type)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 10)
                    }
                    Button("+ Add Ingredient") {
                        viewModel.addEmptyIngredient()
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Instructions")
                    TextEditor(text: $viewModel.instructions)
                        .frame(height: 180)
                        .padding(4)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                Button(recipe == nil ? "Save Recipe" : "Update Recipe") {
                    viewModel.saveRecipe(recipe: recipe, context: context, allCategories: Array(categories))
                    if viewModel.errorMessage.isEmpty {
                        dismiss()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle(recipe == nil ? "Add Recipe" : "Edit Recipe")
        .onAppear {
            if let recipe {
                viewModel.load(recipe: recipe)
            } else if viewModel.ingredients.isEmpty {
                viewModel.addEmptyIngredient()
            }
        }
    }
}
