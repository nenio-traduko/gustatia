//
//  Instruction.swift
//  Gustatia
//
//  Created by David Alvarado on 10/2/23.
//

import Foundation
import SwiftData

@Model
final class Instruction: Identifiable {
    var id: Int
    var content: String
    
    init(id: Int, content: String) {
        self.id = id
        self.content = content
    }
}


extension Instruction {
    static let previews = [
        Instruction(id: 0, content: "Heat your oven to 180°C. Melt the butter, either in the microwave or in a bain-marie."),
        Instruction(id: 1, content: "Butter and flour your cake mold. Remove the zest and squeeze your lemons, reserve in 2 bowls."),
        Instruction(id: 2, content: "Add the sugar to the butter, then the eggs 1 by 1. Mix again."),
        Instruction(id: 3, content: "Add the flour all at once, then the lemon juice (except 1 tsp), mix again. Add the lemon zest and lastly the yeast, mix and pour the dough into your mold."),
        Instruction(id: 4, content: "Bake for 30 minutes and check that it is cooked but not too golden. Leave to cool on a rack.")
    ]
    
    @Transient
    var order: Int {
        self.id + 1
    }
    
    @Transient
    var isValid: Bool {
        !content.isEmpty
    }
}
