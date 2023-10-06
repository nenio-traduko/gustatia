//
//  InstructionEditView.swift
//  Gustatia
//
//  Created by David Alvarado on 10/5/23.
//

import SwiftUI

struct InstructionEditView: View {
    @Bindable var instruction: Instruction
    
    var body: some View {
        TextField("Instruction", text: $instruction.content, axis: .vertical)
    }
}

#Preview {
    PreviewGroup(container: PreviewContainer.container) {
        InstructionEditView(instruction: Instruction.previews.first!)
    }
}
