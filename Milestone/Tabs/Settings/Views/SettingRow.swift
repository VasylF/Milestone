//
//  SettingRow.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 02.02.2026.
//

import SwiftUI

struct SettingRow: View {
    var icon: ImageResource
    var title: String
    var value: String

    var body: some View {
        HStack(spacing: Constants.spacing) {
            iconView
            Text(title)
                .font(.inter(.medium, size: .xlMedium))
                .foregroundStyle(.darkBlue)
            
            Spacer(minLength: 8)
            
            Text(value)
                .font(.inter(.medium, size: .xlMedium))
                .foregroundStyle(.mainGray)
        }
        .padding(Constants.padding)
        .background(
            RoundedRectangle(cornerRadius: Constants.connerRadius, style: .continuous)
                .fill(.white)
                .shadow(color: .black.opacity(Constants.Shadow.opacity), radius: Constants.Shadow.radius, x: Constants.Shadow.x, y: Constants.Shadow.y)
        )
    }
    
    private var iconView: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [.blue, .purple],
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .frame(size: Constants.Icon.size)
                .cornerRadius(Constants.Icon.cornerRadius)
            Image(icon)
        }

    }
}

// MARK: - Constants
private enum Constants {
    static let spacing: CGFloat = 12
    static let padding: CGFloat = 16
    static let connerRadius: CGFloat = 16
    enum Icon {
        static let size: CGFloat = 32
        static let cornerRadius: CGFloat = 10
    }
    enum Shadow {
        static let opacity: CGFloat = 0.06
        static let radius: CGFloat = 8
        static let x: CGFloat = 0
        static let y: CGFloat = 2
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        SettingRow(icon: .minof, title: "Version", value: "1.0(1)")
            .padding(GlobalConstants.hPadding)
    }
}

