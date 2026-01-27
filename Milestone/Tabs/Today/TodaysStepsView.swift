//
//  GradientProgressBar.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 27.01.2026.
//

import SwiftUI
import SwiftData


struct TodaysStepsView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showingCreateGoal = false
    @Query(
        sort: [
            SortDescriptor(\StepModel.createdAt, order: .reverse)
        ]
    )
    private var stepModels: [StepModel]
    
    private var grouped: [(day: Date, items: [StepModel])] {
        let cal = Calendar.current
        let dict = Dictionary(grouping: stepModels) { cal.startOfDay(for: $0.date) }
        return dict
            .map { ($0.key, $0.value.sorted { $0.date < $1.date }) }
            .sorted { $0.day < $1.day }
    }
    
    var body: some View {
        if stepModels.isEmpty {
            emptyView
        } else {
            stepsView
        }
    }
    
    private var stepsView: some View {
        ScrollView {
            LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                ForEach(grouped, id: \.day) { group in
                    Section {
                        ForEach(group.items) { stepModel in
                            StepView(step: stepModel)
                        }
                    } header: {
                        sectionHeader(for: group.day)
                    }
                }
            }
        }
    }
    
    private func sectionHeader(for day: Date) -> some View {
        let title = dayHeaderTitle(for: day)
        
        return Text(title)
            .font(.headline)
            .padding(.horizontal, 16)
            .padding(.top, 14)
            .padding(.bottom, 6)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.background) // important for pinned headers
    }

    private func dayHeaderTitle(for day: Date) -> String {
        let cal = Calendar.current
        if cal.isDateInToday(day) { return "Today" }
        if cal.isDateInTomorrow(day) { return "Tomorrow" }

        return day.conver(to: .MMMd)
    }
    
    private var emptyView: some View {
        VStack(spacing: 12) {
            Image(systemName: "figure.walk")
                .font(.system(size: 48))
            Text("Today's steps will appear here")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}


// MARK: - Constants
private enum Constants {
    static let spacing: CGFloat = 15
}


// MARK: - Preview
#Preview {
    NavigationStack {
        TodaysStepsView()
            .modelContainer(GoalContainerMock.previewContainer)
    }
}

