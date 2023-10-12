//
//  PreviewGroup.swift
//  Gustatia
//
//  Created by David Alvarado on 9/29/23.
//

import Foundation
import SwiftUI
import SwiftData

struct PreviewGroup<Content: View>: View {
    var content: () -> Content
    let container: ModelContainer
    
    init( container: ModelContainer, @ViewBuilder content: @escaping () -> Content) {
        self.container = container
        self.content = content
    }

    var body: some View {
        content()
            .modelContainer(container)
    }
}
