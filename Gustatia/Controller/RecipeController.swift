//
//  RecipeController.swift
//  Gustatia
//
//  Created by David Alvarado on 10/4/23.
//

import Foundation
import SwiftData
import OSLog

class RecipeController {
    private let logger: Logger
    
    init(logger: Logger = Logger()) {
        self.logger = logger
    }
    
    func getDraftRecipe(using modelContext: ModelContext) -> Recipe {
        logger.info("Attempting to retrieve draft recipe")
        
        if let existingDraft = getPendingDraft(using: modelContext) {
            logger.debug("Existing draft found - \(String(reflecting: existingDraft))")
            return existingDraft
        }
        
        let recipe = Recipe(
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
        
        logger.debug("No existing draft found, created new draft - \(String(reflecting: recipe))")
        
        modelContext.insert(recipe)
        
        logger.debug("New draft inserted")
        
        return recipe
    }
    
    func addIngredient(to recipe: Recipe, using modelContext: ModelContext) {
        logger.info("Attempting to add ingredient to specified recipe")
        logger.debug("recipe - \(String(describing: recipe))")
        let ingredientCount = recipe.ingredient.count
        let ingredient = Ingredient(id: ingredientCount, name: "", quantity: Quantity(unit: ""))
        
        logger.debug("Created new ingredient - \(String(describing: ingredient))")
        
        do {
            try modelContext.transaction {
                modelContext.insert(ingredient)
                recipe.ingredient.append(ingredient)
            }
            logger.debug("Ingredient inserted")
        } catch {
            logger.error("Error adding ingredient - \(error)")
        }
    }
    
    func addInstruction(to recipe: Recipe, using modelContext: ModelContext) {
        logger.info("Attempting to add instruction to specified recipe")
        logger.debug("recipe - \(String(describing: recipe))")
        let instructionCount = recipe.instruction.count
        let instruction = Instruction(id: instructionCount, content: "")
        
        logger.debug("Created new instruction - \(String(describing: instruction))")
        
        do {
            try modelContext.transaction {
                modelContext.insert(instruction)
                recipe.instruction.append(instruction)
            }
            logger.debug("Instruction inserted")
        } catch {
            logger.error("Error adding instruction - \(error)")
        }
    }
    
    func publish(recipe: Recipe, using modelContext: ModelContext) {
        if recipe.isValid {
            recipe.isDraft = false
        }
        
        do {
            try modelContext.save()
        } catch {
            logger.error("Error saving db - \(error)")
        }
    }
    
    func delete(recipe: [Recipe], at indices: IndexSet, using modelContext: ModelContext) {
        indices.forEach { index in
            modelContext.delete(recipe[index])
        }
    }
    
    private func getPendingDraft(using modelContext: ModelContext) -> Recipe? {
        var draft = FetchDescriptor<Recipe>(
            predicate: #Predicate { $0.isDraft == true }
        )
        
        draft.fetchLimit = 1
        draft.includePendingChanges = true


        do {
            let results = try modelContext.fetch(draft)
            return results.first
        } catch {
            logger.error("Error fetching draft recipes - \(error)")
        }
        
        return nil
    }
}
