//
//  View.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 31.01.2026.
//

import SwiftUI

extension View {
    func frame(size: CGFloat) -> some View {
        frame(width: size, height: size)
    }
    
    /// Clips the view to a rounded rectangle with a continuous corner style.
    /// - Parameter radius: The corner radius to use. Defaults to 12.
    /// - Returns: A view clipped to a rounded rectangle.
    func roundedClip(radius: CGFloat = 12) -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
    
    func defaultShadow(
        color: Color = Color.black.opacity(0.5),
        radius: CGFloat = 15,
        x: CGFloat = 0,
        y: CGFloat = 6
    ) -> some View {
        shadow(color: color, radius: radius, x: x, y: y)
    }
}
