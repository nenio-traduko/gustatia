//
//  GustatiaApp.swift
//  Gustatia
//
//  Created by David Alvarado on 7/18/23.
//

import SwiftUI

@main
struct GustatiaApp: App {

    var body: some Scene {
        WindowGroup {
            RecipeListView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
