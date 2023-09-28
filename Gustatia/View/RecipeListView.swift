//
//  RecipeListView.swift
//  Gustatia
//
//  Created by David Alvarado on 8/18/23.
//

import SwiftUI
import CoreData

struct RecipeListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)])
    private var recipes: FetchedResults<Recipe>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeListItem(recipeTitle: recipe.title!)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                    } label: {
                        Label("Add recipe", systemImage: "plus")
                            .accessibilityLabel("Add recipe")
                    }
                }
            }
            .navigationTitle(Text("Recipes"))
            .navigationBarTitleDisplayMode(.automatic)
            .overlay {
                if recipes.isEmpty {
                    Text("Add a new recipe to get started.")
                }
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
        }
    }
    
    private func onAddRecipe() {
        withAnimation {
            let newRecipe = Recipe(context: viewContext)
            var title = ""
            
            for _ in 0...Int.random(in: 0...25) {
                guard let character = CharacterSet.alphanumerics.description.randomElement() else {
                    continue
                }
                
                title += String(character)
            }
            
            newRecipe.title = title
            newRecipe.id = UUID()
            
            do {
                try viewContext.save()
            } catch {
                print("Error while attempting to add new recipe \(String(describing: newRecipe))")
            }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
