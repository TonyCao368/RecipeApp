//
//  FlexibleCategoryList.swift
//  RecipeApp
//
//  Created by Tony Cao on 3/18/26.
//

import SwiftUI

struct FlexibleCategoryList: View {
    let categories: [Category]
    let selectedNames: Set<String>
    let onTap: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categories, id: \.objectID) { category in
                    CategoryTagView(title: category.name ?? "", isSelected: selectedNames.contains(category.name ?? "")) {
                        onTap(category.name ?? "")
                    }
                }
            }
        }
    }
}
