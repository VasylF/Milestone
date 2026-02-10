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
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius,
                             style: .continuous)
                .fill(.extrimlyLightGray)
        )
        .overlay(
            RoundedRectangle(cornerRadius: Constants.cornerRadius,
                             style: .continuous)
            .stroke(.softGray, lineWidth: Constants.lineWidth)
        )
        .popover(isPresented: $showDatePicker, arrowEdge: .top) {
            VStack(alignment: .leading,
                   spacing: Constants.DatePicker.spacing) {
                DatePicker(
                    Strings.dueDate,
                    selection: Binding<Date>(
                        get: { step.date ?? Date() },
                        set: { newValue in step.date = newValue }
                    ),
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)

                HStack {
                    Spacer()
                    Button(Strings.done) {
                        showDatePicker = false
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .presentationDetents([.medium])
        }
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
            .foregroundStyle(.darkBlue)
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
    }
}

// MARK: - Strings
private enum Strings {
    static let placeholder: String = "Step title"
    static let done = "Done"
    static let dueDate = "To Do Date"
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
    static let cornerRadius: CGFloat = 12
    static let lineWidth: CGFloat = 1
    enum TextField {
        static let cornerRadius: CGFloat = 10
        static let height: CGFloat = 44
        static let opacity: CGFloat = 0.3
        static let lineWidth: CGFloat = 2
    }
    enum DatePicker {
        static let spacing: CGFloat = 12
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

