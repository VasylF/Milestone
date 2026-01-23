//
//  GradientProgressBar.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 23.01.2026.
//

import SwiftUI

struct GradientProgressBar: View {
    var progress: Double // 0...1

    private var clamped: CGFloat { CGFloat(min(max(progress, 0), 1)) }

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.gray.opacity(Constants.trackOpacity))

                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [.blue, .purple, .pink],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: max(Constants.minFillWidth, width * clamped)) // keeps a nice rounded “pill” at low progress
                    .animation(.easeInOut(duration: Constants.animationDuration), value: clamped)
            }
        }
    }
}


// MARK: - Constants
private enum Constants {
    static let animationDuration: TimeInterval = 0.25
    static let trackOpacity: Double = 0.18
    static let minFillWidth: CGFloat = 12
    static let previewHeight: CGFloat = 20
}


// MARK: - Preview
#Preview {
    VStack {
        GradientProgressBar(progress: 0.1)
            .frame(height: Constants.previewHeight)
        GradientProgressBar(progress: 0.5)
            .frame(height: Constants.previewHeight)
        GradientProgressBar(progress: 1)
            .frame(height: Constants.previewHeight)
    }
}
