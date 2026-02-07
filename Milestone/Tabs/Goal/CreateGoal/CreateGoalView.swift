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
            }
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
}

// MARK: - Constants
private enum Constants {
    static let contentSpacing: CGFloat = 20
}

// MARK: - Preview
#Preview {
    CreateGoalView()
}
