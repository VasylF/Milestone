//
//  StepsView.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 27.01.2026.
//

import SwiftUI
import SwiftData


struct StepsView: View {
    @Query(
        sort: [
            SortDescriptor(\StepModel.createdAt, order: .reverse)
        ]
    )
    private var stepModels: [StepModel]
    
    private var grouped: [(label: StepsRowHeader.HeaderType,
                           items: [StepModel])] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        var overdue: [StepModel] = []
        var todayItems: [StepModel] = []
        var upcoming: [StepModel] = []
        var noDueDate: [StepModel] = []

        for step in stepModels {
            guard let date = step.date else {
                noDueDate.append(step)
                continue
            }
            let stepDay = calendar.startOfDay(for: date)
            if stepDay < today {
                overdue.append(step)
            } else if calendar.isDate(stepDay, inSameDayAs: today) {
                todayItems.append(step)
            } else {
                upcoming.append(step)
            }
        }

        // Sort each bucket by their date ascending (nil dates are already in noDueDate)
        overdue.sort { ($0.date ?? .distantPast) < ($1.date ?? .distantPast) }
        todayItems.sort { ($0.date ?? .distantPast) < ($1.date ?? .distantPast) }
        upcoming.sort { ($0.date ?? .distantFuture) < ($1.date ?? .distantFuture) }
        // For no due date, preserve createdAt recency if available
        noDueDate.sort { $0.createdAt < $1.createdAt }

        var sections: [(label: StepsRowHeader.HeaderType, items: [StepModel])] = []
        if !overdue.isEmpty { sections.append((label: .overdue, items: overdue)) }
        if !todayItems.isEmpty { sections.append((label: .today, items: todayItems)) }
        if !upcoming.isEmpty { sections.append((label: .upcoming, items: upcoming)) }
        if !noDueDate.isEmpty { sections.append((label: .noDueDate, items: noDueDate)) }

        return sections
    }
        
    var body: some View {
        VStack(spacing: 0) {
            ScreenHeaderView(
                screenName: Strings.title,
                subtitle: subtitle(),
                rightView: AnyView(addButton)
            )
            
            // Main content
            if stepModels.isEmpty {
                emptyView
            } else {
                stepsView
            }
        }
    }
    
    private var stepsView: some View {
        ScrollView {
            LazyVStack(alignment: .leading,
                       spacing: Constants.spacing) {
                ForEach(grouped, id: \.label) { group in
                    Section {
                        ForEach(group.items) { stepModel in
                            StepView(step: stepModel)
                        }
                    } header: {
                        StepsRowHeader(numberOfItems: group.items.count,
                                       type: group.label)
                        .padding(.leading, Constants.Header.leadingPadding)
                        .padding(.bottom, Constants.Header.bottomPadding)
                        .padding(.top, Constants.Header.topPadding)
                    }
                }
            }
            .padding(.horizontal, GlobalConstants.hPadding)
            .safeAreaPadding(.bottom, GlobalConstants.hPadding)
        }
        .background(.softGray)
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
    
    private var addButton: some View {
        Button {
        } label: {
            Image(.madd)
        }
    }
    
    private func subtitle() -> String {
        let numberOfSteps = stepModels.count
        let completedNumber = stepModels.filter { $0.isCompleted }.count
        return String(format: Strings.subtitle, completedNumber, numberOfSteps)
    }
}

// MARK: - Constants
private enum Strings {
    static let title: String = "Steps"
    static let subtitle: String = "%d of %d steps"
}

// MARK: - Constants
private enum Constants {
    static let spacing: CGFloat = 9
    enum Header {
        static let bottomPadding: CGFloat = 8
        static let topPadding: CGFloat = 28
        static let leadingPadding: CGFloat = 8
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        StepsView()
            .modelContainer(GoalContainerMock.previewContainer)
    }
}

