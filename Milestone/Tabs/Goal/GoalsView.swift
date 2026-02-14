//
//  GradientProgressBar.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 23.01.2026.
//

import SwiftUI
import SwiftData


struct GoalsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var goals: [GoalModel]
    @State private var showingCreateGoal = false
    
    private var activeGoalCount: Int {
        goals.filter { !$0.isGoalCompleted }.count
    }

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeaderView(
                screenName: Strings.title,
                subtitle: "\(activeGoalCount)\(Strings.subtitle)",
                rightView: AnyView(addButton)
            )
            if goals.isEmpty {
                emptyView
            } else {
                goalsView
            }
        }
        .sheet(isPresented: $showingCreateGoal) {
            CreateGoalView()
        }
        .background(.softGray)
    }
    
    private var emptyView: some View {
        VStack(spacing: Constants.spacing) {
            Image(systemName: Constants.Image.target)
                .foregroundStyle(.mainGray)
                .font(Constants.font)
            Text(Strings.emptyStateText)
                .foregroundStyle(.mainGray)
                .font(.inter(.regular, size: .xlMedium))
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
            .padding(.top, Constants.topPadding)
            .padding(.horizontal, GlobalConstants.hPadding)
            .safeAreaPadding(.bottom, GlobalConstants.hPadding)
        }
    }
    
    private var addButton: some View {
        Button {
            showingCreateGoal = true
        } label: {
            Image(.madd)
        }
    }
}


// MARK: - Constants
private enum Constants {
    static let spacing: CGFloat = 15
    static let font: Font = .system(size: 48)
    static let topPadding: CGFloat = 24
    
    enum Image {
        static let target: String = "target"
    }
}

// MARK: - Strings
private enum Strings {
    static let title: String = "Goals"
    static let subtitle: String = " active goals"
    static let emptyStateText: String = "Your goals will appear here"
}

// MARK: - Preview
#Preview {
    NavigationStack {
        GoalsView()
            .modelContainer(GoalContainerMock.previewContainer)
    }
}
