//
//  CustomNavigationBar.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 01.02.2026.
//

import SwiftUI

struct CustomNavigationBar: View {
    let screenName: String
    let subtitle: String?
    let height: CGFloat
    let rightButtonImage: Image?
    let rightButtonActionHandler: (() -> Void)?
    
    var body: some View {
        HStack(alignment: .bottom, spacing: Constants.spacing) {
            leftView
            Spacer()
            if let rightButtonImage {
                rightButton(for: rightButtonImage)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .frame(height: height)
        .padding(.bottom, Constants.bottomPadding)
        .padding(.horizontal, Constants.hPadding)
        .background(gradientView)
    }
    
    private func rightButton(for image: Image) -> some View {
        Button {
            rightButtonActionHandler?()
        } label: {
            image
        }
        .frame(size: Constants.buttonSize)
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
        LinearGradient(
            colors: [.blue, .purple],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea(edges: .top)
    }
}

// MARK: - Constants
private enum Constants {
    static let spacing: CGFloat = 18
    static let bottomPadding: CGFloat = 15
    static let hPadding: CGFloat = 25
    static let buttonSize: CGFloat = 48
}

// MARK: - Preview
#Preview {
    VStack(spacing: 20) {
        CustomNavigationBar(
            screenName: "Steps",
            subtitle: "5 of 12 completed",
            height: 123,
            rightButtonImage: Image(.add),
            rightButtonActionHandler: nil
        )
        .frame(height: 168)
        CustomNavigationBar(
            screenName: "Goals",
            subtitle: nil,
            height: 123,
            rightButtonImage: Image(.add),
            rightButtonActionHandler: nil
        )
        .frame(height: 168)
    }
}
