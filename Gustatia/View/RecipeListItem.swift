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

struct RecipeListItem_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListItem(recipeTitle: "Some Test Title")
    }
}
