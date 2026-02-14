//
//  GradientButton.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 07.02.2026.
//

import SwiftUI

struct GradientButton: View {
    @Binding var isActive: Bool
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
                .background(isActive ? GC.activeGradient : GC.inactiveGradient)
                .roundedClip()
                .defaultShadow()
        }
        .disabled(!isActive)
    }
}

// MARK: - Constants
private enum Constants {
    static let padding: CGFloat = 17
}

// MARK: - Preview
#Preview {
    GradientButton(isActive: .constant(false), title: "Done", action: { })
        .padding()
}

