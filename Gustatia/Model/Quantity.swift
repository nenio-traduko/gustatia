//
//  Quantity.swift
//  Gustatia
//
//  Created by David Alvarado on 9/28/23.
//

import Foundation
import SwiftData

@Model
final class Quantity {
    var value: Double
    var unit: String
    
    init(value: Double, unit: String) {
        self.value = value
        self.unit = unit
    }
}

extension Quantity {
    static let previews: [Quantity] = {
        let quantities = [
            Quantity(value: 2, unit: "medium egg"),
            Quantity(value: 100, unit: "gram"),
            Quantity(value: 100, unit: "gram"),
            Quantity(value: 100, unit: "gram"),
            Quantity(value: 1, unit: "medium lemon"),
            Quantity(value: 0.5, unit: "tbsp")
        ]
        
        return quantities
    }()
    
    @Transient
    var isValid: Bool {
        value > 0 && !unit.isEmpty
    }
}
