//
//  CreateGoalStepView.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 08.02.2026.
//

import SwiftUI

struct CreateGoalStepView: View {
    @State private var stepName: String = ""
    @State private var showDatePicker: Bool = false
    @State private var dueDate: Date? = nil
    let possition: Int
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
        .cardContainerStyle(backgroundColor: .softGray)
        .padding()
    }
    
    private var mainView: some View {
        VStack(alignment: .leading, spacing: Constants.mainVStackSpacing) {
            textField
            dateView
        }
    }
    
    private var orderText: some View {
        Text("#\(possition)")
            .font(.inter(.semiBold, size: .lMedium))
            .foregroundStyle(.mainGray)
            .padding(.trailing, Constants.orderTextTrailingPadding)
    }
    
    private var textField: some View {
        TextField(Strings.placeholder, text: $stepName)
            .font(.inter(.regular, size: .lMedium))
            .textFieldStyle(.plain)
            .padding(.horizontal, Constants.textFieldHorizontalPadding)
            .padding(.vertical, Constants.textFieldVerticalPadding)
            .cardContainerStyle()
    }
    
    private var deleteButton: some View {
        Button {
            deleteAction(possition)
        } label: {
            Image(.remove)
        }
    }
    
    private var dateView: some View {
        DateView(state: convertToDateViewState(dueDate),
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
    static let textFieldVerticalPadding: CGFloat = 13
    static let hStackSpacing: CGFloat = 16
    static let topPadding: CGFloat = 17
    static let mainVStackSpacing: CGFloat = 15
    static let orderTextTrailingPadding: CGFloat = 5
}

// MARK: - Preview
#Preview {
    CreateGoalStepView(possition: 1) { _ in }
}
