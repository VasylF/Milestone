import SwiftUI

struct CardContainerStyle: ViewModifier {
    var cornerRadius: CGFloat = 15
    var strokeCornerRadius: CGFloat = 10
    var strokeOpacity: Double = 0.06
    var shadowColor: Color = Color.black.opacity(0.1)
    var shadowRadius: CGFloat = 15
    var shadowX: CGFloat = 0
    var shadowY: CGFloat = 6
    var strokeWidth: CGFloat = 1

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(Color(.systemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: strokeCornerRadius, style: .continuous)
                    .stroke(Color.primary.opacity(strokeOpacity), lineWidth: strokeWidth)
            )
            .defaultShadow(color: shadowColor, radius: shadowRadius, x: shadowX, y: shadowY)
    }
}

extension View {
    func cardContainerStyle(
        cornerRadius: CGFloat = 15,
        strokeCornerRadius: CGFloat = 10,
        strokeOpacity: Double = 0.06,
        shadowColor: Color = Color(.sRGBLinear, white: 0, opacity: 0.08),
        shadowRadius: CGFloat = 15,
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 6,
        strokeWidth: CGFloat = 1
    ) -> some View {
        self.modifier(CardContainerStyle(
            cornerRadius: cornerRadius,
            strokeCornerRadius: strokeCornerRadius,
            strokeOpacity: strokeOpacity,
            shadowColor: shadowColor,
            shadowRadius: shadowRadius,
            shadowX: shadowX,
            shadowY: shadowY,
            strokeWidth: strokeWidth
        ))
    }
}
