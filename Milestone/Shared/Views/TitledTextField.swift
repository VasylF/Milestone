//
//  TitledTextField.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 08.02.2026.
//

import SwiftUI

struct TitledTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading,
               spacing: Constants.spacing) {
            Text(title)
                .font(.inter(.semiBold, size: .lMedium))
                .foregroundStyle(.grafit)
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField(placeholder, text: $text)
                .font(.inter(.regular, size: .lMedium))
                .textFieldStyle(.plain)
                .padding(.horizontal, Constants.textFieldHorizontalPadding)
                .padding(.vertical, Constants.textFieldVerticalPadding)
                .cardContainerStyle()
        }
    }
}

// MARK: - Constants
private enum Constants {
    static let spacing: CGFloat = 13
    static let textFieldHorizontalPadding: CGFloat = 14
    static let textFieldVerticalPadding: CGFloat = 18
}

// MARK: - Preview
#Preview {
    @Previewable @State var name: String = ""
    VStack(alignment: .leading) {
        TitledTextField(
            title: "GOAL NAME",
            placeholder: "Enter goal name",
            text: $name
        )
        .padding()
        Spacer()
    }
}

