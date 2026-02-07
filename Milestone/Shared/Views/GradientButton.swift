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
                .roundedClip()
                .defaultShadow()
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
