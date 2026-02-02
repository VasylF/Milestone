//
//  SettingRowHeader.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 03.02.2026.
//

import SwiftUI

struct SettingRowHeader: View {
    var text: String
    
    var body: some View {
        Text(text.uppercased())
            .font(.inter(.bold, size: .lMedium))
            .foregroundStyle(.mainGray)
            .padding(.leading, Constants.padding)
            .padding(.bottom, Constants.bottomPadding)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Constants
private enum Constants {
    static let padding: CGFloat = 16
    static let bottomPadding: CGFloat = 15
}
