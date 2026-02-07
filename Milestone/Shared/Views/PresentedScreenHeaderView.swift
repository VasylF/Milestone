//
//  PresentedScreenHeaderView.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 06.02.2026.
//

import SwiftUI

struct PresentedScreenHeaderView: View {
    let screenName: String
    let rightView: AnyView?
    
    init(
        screenName: String,
        rightView: AnyView? = nil
    ) {
        self.screenName = screenName
        self.rightView = rightView
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: Constants.spacing) {
            titleView
            if let rightView {
                Spacer()
                rightView
                    .frame(width: Constants.rightViewSize,
                           height: Constants.rightViewSize)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, Constants.bottomPadding)
        .padding(.horizontal, Constants.hPadding)
        .background(gradientView)
    }
    
    private var titleView: some View {
        Text(screenName)
            .font(.inter(.bold, size: .xxlLarge))
            .foregroundStyle(.white)
    }
    
    private var gradientView: some View {
        LinearGradient(
            colors: [.blue, .purple],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - Constants
private enum Constants {
    static let spacing: CGFloat = 18
    static let bottomPadding: CGFloat = 15
    static let hPadding: CGFloat = 25
    static let rightViewSize: CGFloat = 48
}

// MARK: - Preview
#Preview {
    VStack(spacing: 20) {
        PresentedScreenHeaderView(
            screenName: "Steps",
            rightView: AnyView(Button(action: {}) { Image(.madd) })
        )
        .frame(height: 168)
        PresentedScreenHeaderView(
            screenName: "Goals"
        )
        .frame(height: 168)
    }
}
