import SwiftUI

private enum Constants {
    static let spacing: CGFloat = 16
    static let font: Font = .system(size: 48)
    static let emptyStateText: String = "Your goals will appear here"
    
    enum Image {
        static let target: String = "target"
        static let plus: String = "plus"
    }
}

struct GoalsView: View {
    @State private var showingCreateGoal = false

    var body: some View {
        VStack(spacing: Constants.spacing) {
            Image(systemName: Constants.Image.target)
                .font(Constants.font)
            Text(Constants.emptyStateText)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingCreateGoal = true
                } label: {
                    Image(systemName: Constants.Image.plus)
                }
                .accessibilityLabel("Add Goal")
            }
        }
        .sheet(isPresented: $showingCreateGoal) {
            CreateGoalView()
        }
    }
}

#Preview {
    NavigationStack { GoalsView() }
}
