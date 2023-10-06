//
//  Ingredient.swift
//  Gustatia
//
//  Created by David Alvarado on 9/28/23.
//

import Foundation
import SwiftData

@Model
final class Ingredient: Identifiable {
    
    var id: Int
    
    var name: String
    
    @Relationship(deleteRule: .cascade, minimumModelCount: 1, maximumModelCount: 1)
    var quantity: Quantity
    
    init(id: Int, name: String, quantity: Quantity) {
        self.id = id
        self.name = name
        self.quantity = quantity
    }
}

extension Ingredient {
    static let previews: [Ingredient] = {
       let ingredients = [
            Ingredient(id: 0, name: "Eggs", quantity: Quantity.previews[0]),
            Ingredient(id: 1, name: "Flour", quantity: Quantity.previews[1]),
            Ingredient(id: 2, name: "Sugar", quantity: Quantity.previews[2]),
            Ingredient(id: 3, name: "Butter", quantity: Quantity.previews[3]),
            Ingredient(id: 4, name: "Lemon", quantity: Quantity.previews[4]),
            Ingredient(id: 5, name: "Baking Powder", quantity: Quantity.previews[5])
        ]
        
        return ingredients
    }()
    
    @Transient
    var isValid: Bool {
        !name.isEmpty && quantity.isValid
    }
}
