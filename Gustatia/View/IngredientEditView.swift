//
//  IngredientEditView.swift
//  Gustatia
//
//  Created by David Alvarado on 10/5/23.
//

import Foundation
import SwiftUI

struct IngredientEditView: View {
    @Bindable var ingredient: Ingredient
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                TextField("Ingredient", text: $ingredient.name)
                    .frame(width: geometry.size.width * 0.45)
                TextField("Amount", value: $ingredient.quantity.value, format: .number.precision(.significantDigits(3)))
                    .frame(width: geometry.size.width * 0.2)
                TextField("Units", text: $ingredient.quantity.unit)
                    .frame(width: geometry.size.width * 0.3)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

#Preview {
    PreviewGroup(container: PreviewContainer.container) {
        IngredientEditView(ingredient: Ingredient.previews.first!)
    }
}
