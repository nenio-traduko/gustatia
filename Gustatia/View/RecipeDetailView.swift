//
//  RecipeDetailView.swift
//  Gustatia
//
//  Created by David Alvarado on 9/8/23.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    var body: some View {
        ScrollView {
            Text("This page is still in progress.")
        }.navigationTitle(recipe.title!)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = Recipe(context: PersistenceController.preview.container.viewContext)
        recipe.title = "Some test title"
        recipe.id = UUID()
        return RecipeDetailView(recipe: recipe)
    }
}
