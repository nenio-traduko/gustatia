//
//  RecipeEditView.swift
//  Gustatia
//
//  Created by David Alvarado on 9/8/23.
//

import SwiftUI

struct RecipeEditView: View {
    @Binding var recipe: Recipe
    
    var body: some View {
        List {
        }
    }
}

struct RecipeEditView_Previews: PreviewProvider {
    static var previews: some View {
        return RecipeEditView(recipe: .constant(Recipe(context: PersistenceController.preview.container.viewContext)))
    }
}
