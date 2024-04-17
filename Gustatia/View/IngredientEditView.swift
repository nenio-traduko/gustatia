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
                TextField("Name", text: $ingredient.name)
                    .frame(width: geometry.size.width * 0.45)
                    .accessibilityLabel("Ingredient \(ingredient.id) Name")
                TextField("Amount", value: $ingredient.quantity.value, format: .number.precision(.significantDigits(3)))
                    .frame(width: geometry.size.width * 0.25)
                    .accessibilityLabel("Ingredient \(ingredient.id) Amount")
                TextField("Units", text: $ingredient.quantity.unit)
                    .frame(width: geometry.size.width * 0.25)
                    .accessibilityLabel("Ingredient \(ingredient.id) Units")
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
