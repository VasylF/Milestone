//
//  NewStepView.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 06.02.2026.
//

import SwiftUI
import SwiftData

struct NewStepView: View {
    var stepModel: StepModel? = nil
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var goals: [GoalModel]
    @State private var title: String = ""
    @State private var isShowingDatePicker = false
    @State private var selectedDate: Date? = nil
    @State private var goalName: (String, UUID?) = (Strings.noGoal, nil)
    @State private var isShowingGoalMenu: Bool = false
    @State private var isKeyboardVisible: Bool = false
    private var predefinedGoals: [(String, UUID?)] {
        var tmpGoals: [(String, UUID?)] = goals.map { model in
            (model.name, Optional(model.id))
        }
        tmpGoals.append((Strings.noGoal, nil))
        return tmpGoals
    }
    
    private var isEditing: Bool {
        stepModel != nil
    }
    
    private var dateState: DateViewState {
        if let selectedDate {
            return convertToDateViewState(selectedDate)
        } else if let stepDate = stepModel?.date {
            return convertToDateViewState(stepDate)
        } else {
            return .noDate
        }
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
                if !isKeyboardVisible {
                    createStepButton
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .padding(.horizontal, GlobalConstants.hPadding)
            .padding(.top, Constants.topPadding)
            .safeAreaPadding(.bottom, Constants.topPadding)
        }
        .background(.softGray)
        .onAppear {
            // Initialize editable fields from model when editing
            if let stepModel = stepModel {
                title = stepModel.title
                selectedDate = stepModel.date
                // Preselect goal if step is linked to a goal
                if let linkedGoalName = stepModel.goalName,
                   let matchedGoal = goals.first(where: { $0.name == linkedGoalName }) {
                    goalName = (matchedGoal.name, matchedGoal.id)
                } else {
                    goalName = (Strings.noGoal, nil)
                }
            } else {
                goalName = (Strings.noGoal, nil)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            withAnimation(.easeInOut(duration: 0.2)) { isKeyboardVisible = true }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            withAnimation(.easeInOut(duration: 0.2)) { isKeyboardVisible = false }
        }
    }
    
    private var stepNameView: some View {
        TitledTextField(
            title: Strings.stepNameTitle,
            placeholder: Strings.stepNamePlaceholder,
            text: $title
        )
    }
    
    private var goalNameView: some View {
        VStack(alignment: .leading,
               spacing: Constants.contentViewSpacing) {
            Text(Strings.goalTitle)
                .font(.inter(.semiBold, size: .lMedium))
                .foregroundStyle(.grafit)
                .frame(maxWidth: .infinity, alignment: .leading)
            Menu {
                ForEach(Array(predefinedGoals.enumerated()), id: \.offset) { _, goal in
                    Button(goal.0) {
                        goalName = goal
                    }
                }
            } label: {
                HStack {
                    Text(goalName.0)
                        .font(.inter(.regular, size: .lMedium))
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
                selectedDate = stepModel?.date ?? selectedDate ?? Date()
                isShowingDatePicker = true
            }
            .popover(isPresented: $isShowingDatePicker, arrowEdge: .top) {
                VStack(alignment: .leading,
                       spacing: Constants.DatePicker.spacing) {
                    let bindingDate = Binding<Date>(
                        get: { selectedDate ?? Date() },
                        set: { selectedDate = $0 }
                    )
                    DatePicker(
                        Strings.todoDate,
                        selection: bindingDate,
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
        GradientButton(isActive: .constant(!title.isEmpty),
                       title: isEditing ? Strings.updateStep : Strings.createStep) {
            if isEditing {
                updateExistingStep()
            } else {
                createNewStep()
            }
            dismiss()
        }
        .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(.close)
        }
    }
    
    private func createNewStep() {
        let stepModel = StepModel(
            id: UUID(),
            title: title,
            isCompleted: false,
            date: selectedDate)
        // Link to GoalModel if a goal was selected
        if let goalId = goalName.1, let selectedGoal = goals.first(where: { $0.id == goalId }) {
            // Assuming StepModel has an optional relationship property `goal`
            stepModel.goal = selectedGoal
            selectedGoal.steps.append(stepModel)
        }
        modelContext.insert(stepModel)
    }
    
    private func updateExistingStep() {
        guard let step = stepModel else { return }

        // Update basic fields
        step.title = title
        step.date = selectedDate

        // Resolve currently linked goal (by name) and newly selected goal (by id)
        let oldGoal = goals.first(where: { $0.name == step.goalName })
        let newGoal: GoalModel? = {
            if let newGoalId = goalName.1 {
                return goals.first(where: { $0.id == newGoalId })
            } else {
                return nil
            }
        }()

        // If the goal association has changed, update relationships
        let goalChanged: Bool = {
            switch (oldGoal?.id, newGoal?.id) {
            case let (lhs?, rhs?):
                return lhs != rhs
            case (nil, nil):
                return false
            default:
                return true
            }
        }()

        if goalChanged {
            // Remove from old goal if present
            if let oldGoal {
                if let index = oldGoal.steps.firstIndex(where: { $0.id == step.id }) {
                    oldGoal.steps.remove(at: index)
                }
            }
            // Link to new goal if selected, otherwise clear linkage
            if let newGoal {
                // Ensure not duplicated before appending
                if !newGoal.steps.contains(where: { $0.id == step.id }) {
                    newGoal.steps.append(step)
                }
                step.goal = newGoal
            } else {
                step.goal = nil
            }
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
    static let updateStep: String = "Update Step"
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

