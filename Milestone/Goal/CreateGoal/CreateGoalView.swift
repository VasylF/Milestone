import SwiftUI

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
    
    enum Image {
        static let trash = "trash"
    }
}

struct CreateGoalView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var steps: [String] = []

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
                            HStack {
                                TextField("Step \(index + 1)", text: Binding(
                                    get: { steps[index] },
                                    set: { steps[index] = $0 }
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
                    }
                    Button {
                        steps.append("")
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
                        // TODO: Handle save action
                        dismiss()
                    }
                    .disabled(
                        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                        steps.first(where: { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }) == nil
                    )
                }
            }
        }
    }
}

#Preview {
    CreateGoalView()
}
