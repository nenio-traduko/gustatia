//
//  RecipeControllerEnvironmentKey.swift
//  Gustatia
//
//  Created by David Alvarado on 10/4/23.
//

import Foundation
import SwiftUI

private struct RecipeControllerEnvironmentKey: EnvironmentKey {
    static let defaultValue: RecipeController = RecipeController()
}

extension EnvironmentValues {
    var recipeController: RecipeController {
        get { self[RecipeControllerEnvironmentKey.self] }
        set { self[RecipeControllerEnvironmentKey.self] = newValue }
    }
}
