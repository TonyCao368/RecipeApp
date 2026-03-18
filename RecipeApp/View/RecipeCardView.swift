//
//  RecipeCardView.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/17/26.
//

import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe
    let onFavoriteTapped: () -> Void
    
    var sortedCategories: [Category] {
        let set = recipe.categories as? Set<Category> ?? []
        return set.sorted { ($0.name ?? "") < ($1.name ?? "") }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: recipe.imageName ?? "photo")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.1))
            HStack {
                Text(recipe.name ?? "")
                    .font(.headline)
                Spacer()
                Button(action: onFavoriteTapped) {
                    Image(systemName: recipe.isFavorite ? "heart.fill": "heart")
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
        }
        .padding()
        .background(Color.white)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray))
    }
}
