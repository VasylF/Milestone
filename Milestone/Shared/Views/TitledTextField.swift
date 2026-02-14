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
                .foregroundStyle(.darkBlue)
                .textFieldStyle(.plain)
                .padding(.horizontal, Constants.textFieldHorizontalPadding)
                .padding(.vertical, Constants.textFieldVerticalPadding)
                .background(
                    RoundedRectangle(cornerRadius: Constants.TextField.cornerRadius,
                                     style: .continuous)
                        .fill(.white)
                        .frame(height: Constants.TextField.height)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.TextField.cornerRadius,
                                     style: .continuous)
                    .stroke(.mainGray, lineWidth: Constants.TextField.lineWidth)
                    .frame(height: Constants.TextField.height)
                )
                .frame(height: Constants.TextField.height)
        }
    }
}

// MARK: - Constants
private enum Constants {
    static let spacing: CGFloat = 13
    static let textFieldHorizontalPadding: CGFloat = 14
    static let textFieldVerticalPadding: CGFloat = 18
    enum TextField {
        static let cornerRadius: CGFloat = 10
        static let height: CGFloat = 44
        static let opacity: CGFloat = 0.3
        static let lineWidth: CGFloat = 1
    }
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

