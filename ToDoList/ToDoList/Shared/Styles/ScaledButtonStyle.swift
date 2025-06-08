//
//  ScaledButtonStyle.swift
//  ToDoList
//
//  Created by Galina Abdurashitova on 08.06.2025.
//

import Foundation
import SwiftUI

struct ScaledButtonStyle: ButtonStyle {
    var scale: CGFloat = 0.6
    
    func makeBody(configuration: Configuration) -> some View {
        let scale = configuration.isPressed ? scale : 1.0
        return configuration.label
            .scaleEffect(scale)
            .animation(.bouncy(duration: 0.3), value: configuration.isPressed)
            .contentShape(Rectangle())
    }
}
