//
//  CustomCheckMark.swift
//  ToDoList
//
//  Created by Galina Abdurashitova on 08.06.2025.
//

import SwiftUI

struct CustomCheckMark: View {
    var body: some View {
        HStack(alignment: .center, spacing: -5) {
            Rectangle()
                .frame(width: 8, height: 4)
                .rotationEffect(Angle(degrees: 40))
                .padding(.top, 4)
            Rectangle()
                .frame(width: 16, height: 4)
                .rotationEffect(Angle(degrees: -50))
        }
        .foregroundColor(.white)
    }
}

#Preview {
    CustomCheckMark()
}
