//
//  Recipe.swift
//  Gustatia
//
//  Created by David Alvarado on 9/28/23.
//

import Foundation
import SwiftData
import OSLog

@Model
final class Recipe: Identifiable {
    @Attribute(.unique) let id: UUID
    
    var title: String
    
    var servings: Double
    
    var prepTime: TimeInterval
    
    var cookTime: TimeInterval
    
    @Transient var totalTime: TimeInterval {
        prepTime + cookTime
    }
    
    @Relationship(deleteRule: .cascade)
    var ingredient: [Ingredient]
    
    @Relationship(deleteRule: .cascade)
    var instruction: [Instruction]
    
    var editDate: Date
    
    var isDraft: Bool
    
    init(id: UUID, title: String, servings: Double, prepTime: TimeInterval, cookTime: TimeInterval, ingredients: [Ingredient], instructions: [Instruction], editDate: Date, isDraft: Bool) {
        self.id = id
        self.title = title
        self.servings = servings
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.ingredient = ingredients
        self.instruction = instructions
        self.editDate = editDate
        self.isDraft = isDraft
    }
}

extension Recipe {
    @Transient
    static let preview = Recipe(
        id: UUID(),
        title: "Lemon Pound Cake",
        servings: 3,
        prepTime: 1500,
        cookTime: 1800,
        ingredients: Ingredient.previews,
        instructions: Instruction.previews,
        editDate: .now,
        isDraft: false
    )
    
    @Transient
    static let empty = Recipe(
        id: UUID(),
        title: "",
        servings: 0.0,
        prepTime: 0.0,
        cookTime: 0.0,
        ingredients: [
            Ingredient(id: 0, name: "", quantity: Quantity(unit: ""))
        ],
        instructions: [
            Instruction(id: 0, content: "")
        ],
        editDate: .now,
        isDraft: true
    )
    
    @Transient
    var orderedIngredient: [Ingredient] {
        self.ingredient.sorted { (leftIngredient, rightIngredient) in
            leftIngredient.id < rightIngredient.id
        }
    }
    
    @Transient
    var orderedInstruction: [Instruction] {
        self.instruction.sorted { (leftInstruction, rightInstruction) in
            leftInstruction.id < rightInstruction.id
        }
    }
    
    @Transient
    var isValid: Bool {
        !title.isEmpty &&
        servings > 0 &&
        !ingredient.isEmpty &&
        ingredient.allSatisfy { ingredient in
            ingredient.isValid
        } &&
        !instruction.isEmpty &&
        instruction.allSatisfy { instruction in
            instruction.isValid
        }
    }
}
