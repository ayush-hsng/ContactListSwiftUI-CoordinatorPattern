//
//  RoundedCorner.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 30/01/24.
//

import SwiftUI

struct RoundedCorners: Shape {
    var radius: CGFloat = 16
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
