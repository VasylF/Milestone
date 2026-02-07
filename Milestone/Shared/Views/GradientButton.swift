//
//  GradientButton.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 07.02.2026.
//

import SwiftUI

struct GradientButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .font(.inter(.bold, size: .xlMedium))
                .foregroundStyle(.white)
                .padding(Constants.padding)
                .frame(maxWidth: .infinity)
                .background(GC.defaultGradient)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
        }
    }
}

// MARK: - Constants
private enum Constants {
    static let padding: CGFloat = 17
}

// MARK: - Preview
#Preview {
    GradientButton(title: "Done", action: { })
        .padding()
}
