//
//  CustomCorner.swift
//  ToDoList
//
//  Created by Galina Abdurashitova on 08.06.2025.
//

import Foundation
import SwiftUI

extension View {
    func customCorner(corners: UIRectCorner, radius: CGFloat) -> some View {
        self.clipShape(CustomCorner(corners: corners, radius: radius))
    }
}

struct CustomCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
