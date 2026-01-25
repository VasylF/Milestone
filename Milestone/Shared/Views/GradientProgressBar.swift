//
//  GradientProgressBar.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 23.01.2026.
//

import SwiftUI

struct GradientProgressBar: View {
    let completedNumberOfSteps: Int
    let numberOfSteps: Int
    
    private var title: String {
        "\(completedNumberOfSteps) of \(numberOfSteps) completed"
    }
    private var progressPercentage: String {
        "\(Int(progress * 100))%"
    }
    // 0...1
    private var progress: Double {
        guard numberOfSteps > 0 else { return 0 }
        return Double(completedNumberOfSteps) / Double(numberOfSteps)
    }

    private var clamped: CGFloat { CGFloat(min(max(progress, 0), 1)) }

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: Constants.spacing) {
                HStack {
                    Text(title)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(progressPercentage)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.mainPurple)
                }
                
                let width = geo.size.width
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.gray.opacity(Constants.trackOpacity))
                    
                    if completedNumberOfSteps > 0 {
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
                            .transition(.opacity)
                    }
                }
                .frame(height: Constants.progressBarHeight)
            }
        }
        .frame(height: Constants.viewHeight)
    }
}


// MARK: - Constants
private enum Constants {
    static let animationDuration: TimeInterval = 0.25
    static let trackOpacity: Double = 0.18
    static let minFillWidth: CGFloat = 12
    static let previewHeight: CGFloat = 40
    static let progressBarHeight: CGFloat = 12
    static let spacing: CGFloat = 10
    static let viewHeight: CGFloat = 35
}


// MARK: - Preview
#Preview {
    VStack(alignment: .center) {
        GradientProgressBar(completedNumberOfSteps: 2, numberOfSteps: 4)
        GradientProgressBar(completedNumberOfSteps: 0, numberOfSteps: 5)
        GradientProgressBar(completedNumberOfSteps: 5, numberOfSteps: 5)
        GradientProgressBar(completedNumberOfSteps: 3, numberOfSteps: 5)
    }
    .padding(.horizontal, 20)
}
