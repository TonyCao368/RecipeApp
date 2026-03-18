//
//  CategoryTagView.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/17/26.
//

import SwiftUI

struct CategoryTagView: View {
    let title: String
    let isSelected: Bool
    let action:() -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.clear)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

