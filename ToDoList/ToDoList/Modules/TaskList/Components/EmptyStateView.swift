//
//  EmptyStateView.swift
//  ToDoList
//
//  Created by Galina Abdurashitova on 08.06.2025.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "sparkles")
                .font(.system(size: 72))
                .foregroundColor(.accentColor)
                .symbolEffect(.breathe.pulse.byLayer, options: .repeat(.continuous))
            
            Text("No tasks yet. Add one!")
                .fontDesign(.monospaced)
        }
        .opacity(0.4)
    }
}

#Preview {
    EmptyStateView()
}
