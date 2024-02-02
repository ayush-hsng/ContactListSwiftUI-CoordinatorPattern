//
//  CTAButton.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 24/01/24.
//

import SwiftUI

struct CTAButtonLabel<Content: View>: View {
    var backgroundColor: Color
    var content: Content

    init(backgroundColor: Color, @ViewBuilder content: () -> Content) {
        self.backgroundColor = backgroundColor
        self.content = content()
    }

    var body: some View {
        HStack {
            Spacer()
            content
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.white.opacity(0.5))
                )
            Spacer()
        }
    }
}

#Preview {
    CTAButtonLabel(backgroundColor: .blue
    , content: {
        Text("CTA Button")
    })
}
