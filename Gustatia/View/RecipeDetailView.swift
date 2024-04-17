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
        List {
            Section {
                Text(String(format: "Servings: %.2f", recipe.servings)).font(.subheadline)
                Text("Total time: \(recipe.totalTime.formattedString)").font(.subheadline)
            } header: {
                Text("About")
            }
            Section {
                ForEach(recipe.orderedIngredient) { ingredient in
                    HStack(alignment: .bottom) {
                        Text(ingredient.name)
                        Spacer()
                        Text(String(format: "%.2f \(ingredient.quantity.unit)", ingredient.quantity.value ?? 0.0))
                    }
                }
            } header: {
                Text("Ingredients")
            }
            Section {
                ForEach(recipe.orderedInstruction) { instruction in
                    Text("\(instruction.order). \(instruction.content)").font(.body)
                }
            } header: {
                Text("Instructions")
            }
        }
        .navigationTitle(recipe.title)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                NavigationLink(value: EditRecipeNavigator(recipe: recipe)) {
                    Label("Edit", systemImage: "square.and.pencil")
                }
            }
        }
    }
}

#Preview {
    PreviewGroup(container: PreviewContainer.container) {
        RecipeDetailView(recipe: .preview)
    }
}
