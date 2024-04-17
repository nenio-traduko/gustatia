//
//  RecipeEditView.swift
//  Gustatia
//
//  Created by David Alvarado on 9/8/23.
//

import SwiftUI
import SwiftData

struct RecipeEditView: View {
    @Environment(\.dismiss) private var dismiss: DismissAction
    @Environment(\.recipeController) private var recipeController: RecipeController
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Bindable var recipe: Recipe
    
    var body: some View {
        Form {
            Section("Recipe") {
                TextField("Title", text: $recipe.title, prompt: Text("Title"))
            }
            
            Section("Servings") {
                Stepper(String(format: "%0.2f", recipe.servings),
                        onIncrement: { recipe.servings += 0.5 },
                        onDecrement: {
                    if recipe.servings - 0.5 >= 0 {
                        recipe.servings -= 0.5
                    }
                }).accessibilityLabel("Servings Stepper")
            }
            
            Section("Preparation Time") {
                Stepper(recipe.prepTime.formattedString,
                        onIncrement: { recipe.prepTime += 300 },
                        onDecrement: {
                    if recipe.prepTime - 300 >= 0 {
                        recipe.prepTime -= 300
                    }
                }).accessibilityLabel("Preparation Time Stepper")
            }
            
            Section("Cook Time") {
                Stepper(recipe.cookTime.formattedString,
                        onIncrement: { recipe.cookTime += 300 },
                        onDecrement: {
                    if recipe.cookTime - 300 >= 0 {
                        recipe.cookTime -= 300
                    }
                }).accessibilityLabel("Cook Time Stepper")
            }
            
            Section("Ingredients") {
                ForEach(recipe.orderedIngredient) { ingredient in
                    IngredientEditView(ingredient: ingredient)
                }
                
                Button(action: {
                    recipeController.addIngredient(to: recipe, using: modelContext)
                }, label: {
                    Label("Add Ingredient", systemImage: "plus")
                })
            }
            
            Section("Instructions") {
                ForEach(recipe.orderedInstruction) { instruction in
                    InstructionEditView(instruction: instruction)
                }
                
                Button(action: {
                    recipeController.addInstruction(to: recipe, using: modelContext)
                }, label: {
                    Label("Add Step", systemImage: "plus")
                })
            }
        }.toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    withAnimation {
                        recipeController.publish(recipe: recipe, using: modelContext)
                        dismiss()
                    }
                }, label: {
                    Label("Done", systemImage: "checkmark")
                })
            }
        }.navigationTitle("Edit Recipe")
    }
}

#Preview("Empty") {
    PreviewGroup(container: PreviewContainer.container) {
        RecipeEditView(recipe: Recipe.empty)
    }
}

#Preview("Filled") {
    PreviewGroup(container: PreviewContainer.container) {
        RecipeEditView(recipe: Recipe.preview)
    }
}
