//
//  ScreenHeaderView.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 01.02.2026.
//

import SwiftUI

struct ScreenHeaderView: View {
    let screenName: String
    let subtitle: String?
    let rightView: AnyView?
    
    init(
        screenName: String,
        subtitle: String? = nil,
        rightView: AnyView? = nil
    ) {
        self.screenName = screenName
        self.subtitle = subtitle
        self.rightView = rightView
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: Constants.spacing) {
            leftView
            Spacer()
            if let rightView {
                rightView
                    .frame(width: Constants.rightViewSize,
                           height: Constants.rightViewSize)
            }
        }
        .frame(maxWidth: .infinity, alignment: .bottom)
        .padding(.bottom, Constants.bottomPadding)
        .padding(.horizontal, Constants.hPadding)
        .background(gradientView)
    }
    
    private var leftView: some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            titleView
            subtitleView
        }
    }
    
    private var titleView: some View {
        Text(screenName)
            .font(.inter(.bold, size: .xxlLarge))
            .foregroundStyle(.white)
    }
    
    private var subtitleView: some View {
        Text(subtitle ?? "")
            .font(.inter(.medium, size: .medium))
            .foregroundStyle(.white)
    }
    
    private var gradientView: some View {
        GC.activeGradient
        .ignoresSafeArea(edges: .top)
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
        ScreenHeaderView(
            screenName: "Steps",
            subtitle: "5 of 12 completed",
            rightView: AnyView(Button(action: {}) { Image(.madd) })
        )
        .frame(height: 168)
        ScreenHeaderView(
            screenName: "Goals",
            subtitle: nil
        )
        .frame(height: 168)
    }
}
