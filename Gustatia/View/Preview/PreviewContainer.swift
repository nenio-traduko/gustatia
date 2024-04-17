//
//  PreviewContainer.swift
//  Gustatia
//
//  Created by David Alvarado on 9/29/23.
//

import Foundation
import SwiftData

actor PreviewContainer {
    @MainActor
    static var container: ModelContainer = {
        let container = try! ModelContainer(for: Recipe.self, Ingredient.self, Quantity.self, Instruction.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        container.mainContext.insert(Recipe.preview)
        container.mainContext.insert(Recipe.empty)
        
        return container
    }()
}
