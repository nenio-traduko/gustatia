//
//  GustatiaApp.swift
//  Gustatia
//
//  Created by David Alvarado on 7/18/23.
//

import SwiftUI

@main
struct GustatiaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
