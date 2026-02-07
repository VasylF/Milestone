//
//  NewStepView.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 06.02.2026.
//

import SwiftUI

struct NewStepView: View {
    @Environment(\.dismiss) private var dismiss
    var stepModel: StepModel? = nil
    @State private var title: String = ""
    @State private var isShowingDatePicker = false
    @State private var selectedDate: Date = Date()
    @State private var goalName: String = Strings.noGoal
    @State private var isShowingGoalMenu: Bool = false
    private let predefinedGoals: [String] = [
        "Health",
        "Career",
        "Personal Development",
        "Finance",
        "Relationships",
        "Hobby",
        Strings.noGoal
    ]
    
    private var isEditing: Bool {
        stepModel != nil
    }
    
    private var dateState: DateViewState {
        stepModel?.convertToState() ?? stepModel?.convertToState(selectedDate) ?? .noDate
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            PresentedScreenHeaderView(
                screenName: isEditing ? Strings.editStep : Strings.newStep,
                rightView: AnyView(closeButton)
            )
            VStack(alignment: .leading,
                   spacing: Constants.contentSpacing) {
                stepNameView
                goalNameView
                dateView
                Spacer()
                createStepButton
            }
            .padding(.horizontal, GlobalConstants.hPadding)
            .padding(.top, Constants.topPadding)
        }
        .background(.softGray)
        .onAppear {
            // Initialize editable title from model when editing
            if let stepModel = stepModel {
                title = stepModel.title
            }
        }
    }
    
    private var stepNameView: some View {
        VStack(alignment: .leading,
               spacing: Constants.contentViewSpacing) {
            Text(Strings.stepNameTitle)
                .font(.inter(.semiBold, size: .lMedium))
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(Strings.stepNamePlaceholder, text: $title)
                .textInputAutocapitalization(.sentences)
                .disableAutocorrection(false)
                .padding(.horizontal, Constants.TextField.horizontalPadding)
                .padding(.vertical, Constants.TextField.verticalPadding)
                .background(Color.white)
                .cornerRadius(Constants.cornerRadius)
                .cardContainerStyle()
        }
    }
    
    private var goalNameView: some View {
        VStack(alignment: .leading,
               spacing: Constants.contentViewSpacing) {
            Text(Strings.goalTitle)
                .font(.inter(.semiBold, size: .lMedium))
                .frame(maxWidth: .infinity, alignment: .leading)
            Menu {
                ForEach(predefinedGoals, id: \.self) { goal in
                    Button(goal) {
                        goalName = goal
                    }
                }
            } label: {
                HStack {
                    Text(goalName)
                        .font(Font.inter(.regular, size: .xlMedium))
                        .foregroundStyle(.darkBlue)
                    Spacer()
                    Image(.upDownArrow)
                }
                .contentShape(Rectangle())
            }
            .menuStyle(.button)
            .padding(.horizontal, Constants.Menu.horizontalPadding)
            .background(Color.white)
            .cornerRadius(Constants.cornerRadius)
            .cardContainerStyle()
        }
    }
    
    private var dateView: some View {
        VStack(alignment: .leading,
               spacing: Constants.contentViewSpacing) {
            Text(Strings.todoDateTitle)
                .font(.inter(.semiBold, size: .lMedium))
                .frame(maxWidth: .infinity, alignment: .leading)
            DateView(state: dateState, isCompleted: false) {
                selectedDate = stepModel?.date ?? Date()
                isShowingDatePicker = true
            }
            .popover(isPresented: $isShowingDatePicker, arrowEdge: .top) {
                VStack(alignment: .leading,
                       spacing: Constants.DatePicker.spacing) {
                    DatePicker(
                        Strings.todoDate,
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)

                    HStack {
                        Spacer()
                        Button(Strings.done) {
                            isShowingDatePicker = false
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding()
                .presentationDetents([.medium])
            }
            
        }
    }
    
    private var createStepButton: some View {
        GradientButton(title: Strings.createStep) {
            
        }
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(.close)
        }
    }
}

// MARK: - Strings
private enum Strings {
    static let newStep: String = "New Step"
    static let editStep: String = "Edit Step"
    static let stepNameTitle: String = "Step Name"
    static let stepNamePlaceholder: String = "Enter step name"
    static let todoDateTitle: String = "To Do Date (Optional)"
    static let goalTitle: String = "Link to a Goal (Optional)"
    static let noGoal: String = "No Goal"
    static let todoDate: String = "To Do Date"
    static let done: String = "Done"
    static let createStep: String = "Create Step"
}

// MARK: - Constants
private enum Constants {
    static let topPadding: CGFloat = 25
    static let contentSpacing: CGFloat = 25
    static let contentViewSpacing: CGFloat = 13
    static let cornerRadius: CGFloat = 12
    enum TextField {
        static let horizontalPadding: CGFloat = 12
        static let verticalPadding: CGFloat = 10
    }
    enum Menu {
        static let horizontalPadding: CGFloat = 12
    }
    enum DatePicker {
        static let spacing: CGFloat = 12
    }
}

// MARK: - Preview
#Preview {
    NewStepView(stepModel: nil)
}

