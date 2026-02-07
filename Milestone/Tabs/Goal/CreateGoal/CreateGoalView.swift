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
}

// MARK: - Constants
private enum Constants {
    static let contentSpacing: CGFloat = 20
    enum StepButton {
        static let vPadding: CGFloat = 11
    }
}

// MARK: - Preview
#Preview {
    CreateGoalView()
}
