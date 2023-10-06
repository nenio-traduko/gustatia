//
//  GustatiaApp.swift
//  Gustatia
//
//  Created by David Alvarado on 7/18/23.
//

import SwiftUI
import SwiftData

@main
struct GustatiaApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeListView()
        }
        .modelContainer(for: Recipe.self)
        .environment(\.recipeController, RecipeController())
    }
}
