import SwiftUI
import SwiftData

struct CreateGoalView: View {
    let goalModel: GoalModel? = nil
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var title: String = ""
    @State private var steps: [StepModel] = []
    
    private var isEditing: Bool {
        goalModel != nil
    }
    private var buttonTitle: String {
        isEditing ? Strings.updateGoalButtonTitle : Strings.createGoalButtonTitle
    }

    var body: some View {
        VStack(spacing: .zero) {
            PresentedScreenHeaderView(
                screenName: isEditing ? Strings.editGoal : Strings.newGoal,
                rightView: AnyView(closeButton)
            )
            goalsSectionView
            Spacer()
            createGoalButton
                .padding(.bottom, Constants.bottomPadding)
                .padding(.horizontal, Constants.horizontalPadding)
                .padding(.top, Constants.topPadding)
        }
        .foregroundStyle(.softGray)
    }
    
    private var goalsSectionView: some View {
        ScrollView {
            LazyVStack(alignment: .leading,
                       spacing: Constants.contentSpacing) {
                goalNameTextField
                    .padding(.top, Constants.topPadding)
                stepsHeaderTitle
                ForEach(Array(steps.enumerated()), id: \.element.id) { index, step in
                    CreateGoalStepView(
                        step: step,
                        position: index + 1) { position in
                        removeStep(at: position)
                    }
                }
                addStepButton
            }
                       .padding(.horizontal, Constants.horizontalPadding)
        }
    }
    
    private var addStepButton: some View {
        Button {
            let newStep = StepModel(id: UUID(), title: "", isCompleted: false, date: nil)
            steps.append(newStep)
        } label: {
            HStack(spacing: Constants.StepButton.spacing) {
                Image(.addStep)
                Text(Strings.addStep)
                    .font(.inter(.medium, size: .medium))
            }
            .foregroundStyle(.mdarkGray)
            .frame(maxWidth: .infinity)
            .padding(.vertical, Constants.StepButton.vPadding)
            .background(
                RoundedRectangle(cornerRadius: Constants.StepButton.cornerRadius, style: .continuous)
                    .fill(.lightSoftGray.opacity(Constants.StepButton.opacity))
            )
            .overlay(
                RoundedRectangle(cornerRadius: Constants.StepButton.cornerRadius, style: .continuous)
                    .strokeBorder(.mainGray, lineWidth: Constants.StepButton.lineWidth)
            )
        }
    }
    
    private var createGoalButton: some View {
        GradientButton(isActive: .constant(!title.isEmpty), title: buttonTitle) {
            saveGoal()
            dismiss()
        }
    }
    
    private var goalNameTextField: some View {
        TitledTextField(
            title: Strings.goalNameTitle,
            placeholder: Strings.goalNamePlaceholder,
            text: $title
        )
    }
    
    private var stepsHeaderTitle: some View {
        HStack {
            Text(Strings.stepsHeader.uppercased())
                .font(.inter(.semiBold, size: .lMedium))
                .foregroundStyle(.grafit)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text("\(steps.count) \(Strings.steps)")
                .font(.inter(.regular, size: .lMedium))
                .foregroundStyle(.mainGray)
        }
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(.close)
        }
    }
    
    private func saveGoal() {
        let goal = GoalModel(id: UUID(), name: title, steps: steps)
        modelContext.insert(goal)
    }
    
    private func removeStep(at possition: Int) {
        guard steps.count > 0 && possition - 1 >= 0 else { return }
        
        steps.remove(at: possition - 1)
    }
}

// MARK: - Strings
private enum Strings {
    static let editGoal: String = "Edit Goal"
    static let newGoal: String = "New Goal"
    static let addStep: String = "Add Step"
    static let createGoal: String = "Create Goal"
    static let createGoalButtonTitle: String = "Create Goal"
    static let updateGoalButtonTitle: String = "Update Goal"
    static let goalNameTitle: String = "GOAL NAME"
    static let goalNamePlaceholder: String = "Enter goal name"
    static let stepsHeader: String = "Steps (Optional)"
    static let steps: String = "steps"
}

// MARK: - Constants
private enum Constants {
    static let contentSpacing: CGFloat = 20
    static let horizontalPadding: CGFloat = 20
    static let bottomPadding: CGFloat = 24
    static let topPadding: CGFloat = 24
    
    enum StepButton {
        static let vPadding: CGFloat = 11
        static let spacing: CGFloat = 8
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 1
        static let opacity: Double = 0.3
    }
    
    enum CreateButton {
        static let vPadding: CGFloat = 16
        static let cornerRadius: CGFloat = 16
        static let shadowColor: Color = Color.black.opacity(0.08)
        static let shadowRadius: CGFloat = 12
        static let shadowY: CGFloat = 6
    }
}

// MARK: - Preview
#Preview {
    CreateGoalView()
}

