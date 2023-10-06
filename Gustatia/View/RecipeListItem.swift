//
//  RecipeListItem.swift
//  Gustatia
//
//  Created by David Alvarado on 8/15/23.
//

import SwiftUI

struct RecipeListItem: View {
    let recipeTitle: String
    
    var body: some View {
        HStack {
            Text(recipeTitle)
                .font(.headline)
            Spacer()
        }
        .padding(.all)
    }
}

#Preview {
    PreviewGroup(container: PreviewContainer.container) {
        RecipeListItem(recipeTitle: Recipe.preview.title)
    }
}
