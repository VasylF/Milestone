import SwiftUI
import SwiftData


struct GoalsView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showingCreateGoal = false
    @Query private var goals: [GoalModel]

    var body: some View {
        VStack {
            if goals.isEmpty {
                emptyView
            } else {
                goalsView
                    .padding(.top, Constants.spacing)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingCreateGoal = true
                } label: {
                    Image(systemName: Constants.Image.plus)
                }
            }
        }
        .sheet(isPresented: $showingCreateGoal) {
            CreateGoalView()
        }
    }
    
    private var emptyView: some View {
        VStack(spacing: Constants.spacing) {
            Image(systemName: Constants.Image.target)
                .font(Constants.font)
            Text(Constants.emptyStateText)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
    
    private var goalsView: some View {
        ScrollView {
            LazyVStack(spacing: Constants.spacing) {
                ForEach(goals, id: \.id) { goal in
                    GoalView(goalModel: goal)
                }
            }
            .padding(.horizontal, Constants.spacing)
        }
    }
}


// MARK: - Constants
private enum Constants {
    static let spacing: CGFloat = 15
    static let font: Font = .system(size: 48)
    static let emptyStateText: String = "Your goals will appear here"
    
    enum Image {
        static let target: String = "target"
        static let plus: String = "plus"
    }
}


// MARK: - Preview
#Preview {
    NavigationStack {
        GoalsView()
            .modelContainer(GoalContainerMock.previewContainer)
    }
}
