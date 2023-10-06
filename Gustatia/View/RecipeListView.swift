//
//  RecipeListView.swift
//  Gustatia
//
//  Created by David Alvarado on 8/18/23.
//

import SwiftUI
import SwiftData

struct RecipeListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.recipeController) private var recipeController
    @Query(
        filter: #Predicate<Recipe> { recipe in !recipe.isDraft},
        sort: \Recipe.title,
        order: .forward
    ) private var recipes: [Recipe]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(value: ViewRecipeNavigator(recipe: recipe)) {
                        RecipeListItem(recipeTitle: recipe.title)
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                        recipeController.delete(
                            recipe: recipes,
                            at: indexSet,
                            using: modelContext
                        )
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    NavigationLink(
                        value: EditRecipeNavigator(
                            recipe: recipeController.getDraftRecipe(
                                using: modelContext
                            )
                        )
                    ) {
                        Label("Add recipe", systemImage: "plus")
                            .accessibilityLabel("Add recipe")
                    }
                }
            }
            .navigationTitle(Text("Recipes"))
            .overlay {
                if recipes.isEmpty {
                    Text("Add a recipe to get started.")
                }
            }
            .navigationDestination(for: ViewRecipeNavigator.self) { navigator in
                RecipeDetailView(recipe: navigator.recipe)
            }
            .navigationDestination(for: EditRecipeNavigator.self) { navigator in
                RecipeEditView(recipe: navigator.recipe)
            }
        }
    }
}

#Preview {
    PreviewGroup(container: PreviewContainer.container) {
        RecipeListView()
    }
}
