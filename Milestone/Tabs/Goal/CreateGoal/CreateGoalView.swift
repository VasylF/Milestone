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
            VStack(alignment: .leading,
                   spacing: Constants.contentSpacing) {
                Spacer()
                addStepButton
                createGoalButton
                    .padding(.bottom, Constants.bottomPadding)
            }
        }
    }
    
    private var addStepButton: some View {
        Button {
        } label: {
            HStack(spacing: 8) {
                Image(.addStep)
                Text(Strings.addStep)
                    .font(.inter(.medium, size: .medium))
            }
            .foregroundStyle(.darkGray)
            .frame(maxWidth: .infinity)
            .padding(.vertical, Constants.StepButton.vPadding)
            .cardContainerStyle()
        }
        .buttonStyle(.plain)
    }
    
    private var createGoalButton: some View {
        GradientButton(isActive: .constant(!title.isEmpty), title: buttonTitle) {
            
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
}

// MARK: - Strings
private enum Strings {
    static let editGoal: String = "Edit Goal"
    static let newGoal: String = "New Goal"
    static let addStep: String = "Add Step"
    static let createGoal: String = "Create Goal"
    static let createGoalButtonTitle: String = "Create Goal"
    static let updateGoalButtonTitle: String = "Update Goal"
}

// MARK: - Constants
private enum Constants {
    static let contentSpacing: CGFloat = 20
    static let horizontalPadding: CGFloat = 20
    static let bottomPadding: CGFloat = 24
    
    enum StepButton {
        static let vPadding: CGFloat = 11
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
