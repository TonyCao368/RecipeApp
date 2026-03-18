//
//  HomeView.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/17/26.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel = HomeViewModel()
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.name, ascending: false)], animation: .default)
    var recipes: FetchedResults<Recipe>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)], animation: .default)
    var categories: FetchedResults<Category>
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Welcome, \(authViewModel.currentUsername)!")
                    .font(.title)
                    .bold()
                Spacer()
                NavigationLink {
                    AddEditRecipeView(recipe: nil)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                }
            }
            .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(categories, id: \.objectID) { category in
                                    CategoryTagView(title: category.name ?? "",isSelected: viewModel.selectedCategoryNames.contains(category.name ?? "")) {
                                        viewModel.toggleCategory(category.name ?? "")
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
            HStack {
                Text("Recipes")
                    .font(.headline)
                Spacer()
                Button(viewModel.isAscending ? "Ascending": "Descending") {
                    viewModel.isAscending.toggle()
                }
            }
            .padding(.horizontal)
            List {
                ForEach(viewModel.filteredRecipes(from: Array(recipes)), id: \.objectID) { recipe in
                    NavigationLink {
                        RecipeDetailView(recipe: recipe)
                    } label: {
                        RecipeCardView(recipe: recipe) {
                            viewModel.toggleFavorite(for: recipe, context: context)
                        }
                    }
                }
            }
        }
    }
}
