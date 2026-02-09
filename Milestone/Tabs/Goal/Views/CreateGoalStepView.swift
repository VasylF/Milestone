//
//  CreateGoalStepView.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 08.02.2026.
//

import SwiftUI

struct CreateGoalStepView: View {
    @State private var showDatePicker: Bool = false
    @State var step: StepModel
    let position: Int
    let deleteAction: (Int) -> Void

    var body: some View {
        HStack(alignment: .top, spacing: Constants.hStackSpacing) {
            orderText
                .padding(.top, Constants.topPadding)
            mainView
            deleteButton
                .padding(.top, Constants.topPadding)
        }
        .frame(alignment: .top)
        .padding()
        .cardContainerStyle()
    }
    
    private var mainView: some View {
        VStack(alignment: .leading, spacing: Constants.mainVStackSpacing) {
            textField
            dateView
        }
    }
    
    private var orderText: some View {
        Text("#\(position)")
            .font(.inter(.semiBold, size: .lMedium))
            .foregroundStyle(.mainGray)
            .padding(.trailing, Constants.orderTextTrailingPadding)
    }
    
    private var textField: some View {
        TextField(Strings.placeholder, text: $step.title)
            .font(.inter(.regular, size: .lMedium))
            .padding(.horizontal, Constants.textFieldHorizontalPadding)
            .background(
                RoundedRectangle(cornerRadius: Constants.TextField.cornerRadius, style: .continuous)
                    .fill(.white)
                    .frame(height: Constants.TextField.height)
            )
            .overlay(
                RoundedRectangle(cornerRadius: Constants.TextField.cornerRadius,
                                 style: .continuous)
                .stroke(Color.lightSoftGray.opacity(Constants.TextField.opacity), lineWidth: Constants.TextField.lineWidth)
                    .frame(height: Constants.TextField.height)
            )
            .frame(height: Constants.TextField.height)
    }
    
    private var deleteButton: some View {
        Button {
            deleteAction(position)
        } label: {
            Image(.mremove)
        }
    }
    
    private var dateView: some View {
        DateView(state: convertToDateViewState(step.date),
                 isCompleted: false) {
            showDatePicker = true
        }
                 .cardContainerStyle()
    }
}

// MARK: - Strings
private enum Strings {
    static let placeholder: String = "Step title"
}

// MARK: - Constants
private enum Constants {
    static let spacing: CGFloat = 13
    static let textFieldHorizontalPadding: CGFloat = 12
    static let textFieldVerticalPadding: CGFloat = 11
    static let hStackSpacing: CGFloat = 16
    static let topPadding: CGFloat = 17
    static let mainVStackSpacing: CGFloat = 15
    static let orderTextTrailingPadding: CGFloat = 5
    enum TextField {
        static let cornerRadius: CGFloat = 10
        static let height: CGFloat = 44
        static let opacity: CGFloat = 0.3
        static let lineWidth: CGFloat = 1
    }
}

// MARK: - Preview
#Preview {
    CreateGoalStepView(step: .init(
        id: UUID(),
        title: "Test",
        isCompleted: false,
        date: nil
    ),
                       position: 1) { _ in }
}
