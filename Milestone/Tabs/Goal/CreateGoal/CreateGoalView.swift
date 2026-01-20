import SwiftUI
import SwiftData

private enum Constants {
    static let navigationTitle = "New Goal"
    static let sectionTitleTitle = "Title"
    static let sectionTitleSteps = "Steps"
    static let placeholderGoalTitle = "Goal title"
    static let emptyStepsText = "No steps yet"
    static let addStepLabel = "Add Step"
    static let addStepSystemImage = "plus.circle"
    static let deleteStepAccessibilityPrefix = "Delete Step "
    static let cancel = "Cancel"
    static let save = "Save"
    static let step = "Step"
    static let toDoDate = "To Do Date"
    
    enum Image {
        static let trash = "trash"
    }
}

struct CreateGoalView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var title: String = ""
    @State private var steps: [StepModel] = []

    var body: some View {
        NavigationStack {
            Form {
                Section(Constants.sectionTitleTitle) {
                    TextField(Constants.placeholderGoalTitle, text: $title)
                }
                Section(Constants.sectionTitleSteps) {
                    if steps.isEmpty {
                        Text(Constants.emptyStepsText).foregroundStyle(.secondary)
                    } else {
                        ForEach(steps.indices, id: \.self) { index in
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    TextField("\(Constants.step) \(index + 1)", text: Binding(
                                        get: { steps[index].title },
                                        set: { steps[index].title = $0 }
                                    ))
                                    Button(role: .destructive) {
                                        steps.remove(at: index)
                                    } label: {
                                        Image(systemName: Constants.Image.trash)
                                    }
                                    .buttonStyle(.borderless)
                                    .accessibilityLabel(Constants.deleteStepAccessibilityPrefix + String(index + 1))
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    Button {
                        steps.append(StepModel(id: UUID(), title: "", isCompleted: false, date: Date()))
                    } label: {
                        Label(Constants.addStepLabel, systemImage: Constants.addStepSystemImage)
                    }
                }
            }
            .navigationTitle(Constants.navigationTitle)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(Constants.cancel) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(Constants.save) {
                        saveGoal()
                        dismiss()
                    }
                    .disabled(
                        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                        steps.first(where: { !$0.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }) == nil
                    )
                }
            }
        }
    }
    
    private func saveGoal() {
        let goal = GoalModel(id: UUID(), name: title, steps: steps)
        modelContext.insert(goal)
    }
}

#Preview {
    CreateGoalView()
}
