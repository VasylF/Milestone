//
//  GoalView.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 25.01.2026.
//

import SwiftUI
import SwiftData


struct GoalView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isGoalsListExtended: Bool = false
    
    let goalModel: GoalModel
    
    private var chevronDegrees: CGFloat {
        isGoalsListExtended ? Constants.Chevron.extendedDegrees : Constants.Chevron.collapsedDegrees
    }

    var body: some View {
        VStack(spacing: Constants.Container.spacing) {
            headerView
            gradientProgressBar
                .padding(.leading, Constants.Container.progressBarLeadingPading)
            if isGoalsListExtended, goalModel.steps.count > 0 {
                dividerLine
                stepsList
            }
        }
        .padding(.horizontal, GlobalConstants.hPadding)
        .padding(.vertical, Constants.Container.topPadding)
        .cardContainerStyle()
    }
    
    private var stepsList: some View {
        VStack(spacing: 15) {
            ForEach(goalModel.steps, id: \.id) { step in
                GoalStepView(stepModel: step)
            }
        }
        .animation(.easeInOut(duration: 1), value: isGoalsListExtended)
        .padding(.top, 8)
    }
    
    private var dividerLine: some View {
        Color.gray
            .frame(height: Constants.Divider.height)
            .opacity(Constants.Divider.opacity)
    }
    
    private var chevronButton: some View {
        Button {
            withAnimation(.easeInOut(duration: Constants.Chevron.animationDuration)) {
                isGoalsListExtended.toggle()
            }
        } label: {
            Image(.mchevronRight)
                .frame(
                    width: Constants.Chevron.size,
                    height: Constants.Chevron.size
                )
                .foregroundColor(.mainPurple)
                .rotationEffect(.degrees(chevronDegrees))
                .animation(.easeInOut(duration: Constants.Chevron.animationDuration), value: isGoalsListExtended)
                .contentShape(Rectangle())
        }
    }
    
    private var headerView: some View {
        HStack {
            chevronButton
            Text(goalModel.name)
                .font(.inter(.bold, size: .xlMedium))
                .foregroundStyle(.darkBlue)
            Spacer()
            Menu {
                Button(Strings.edit, action: {})
                Button(Strings.remove,
                       role: .destructive,
                       action: {
                    modelContext.delete(goalModel)
                })
            } label: {
                Image(.more)
            }
        }
    }
    
    private var gradientProgressBar: some View {
        GradientProgressBar(
            completedNumberOfSteps: goalModel.numberOfCompletedSteps,
            numberOfSteps: goalModel.numberOfSteps
        )
    }
}

// MARK: - Strings
private enum Strings {
    static let edit: String = "Edit"
    static let remove: String = "Remove"
}

// MARK: - Constants
private enum Constants {
    static let defaultSpacing: CGFloat = 15
    enum Container {
        static let spacing: CGFloat = 19
        static let topPadding: CGFloat = 28
        static let progressBarLeadingPading: CGFloat = 30
    }
    
    enum Divider {
        static let height: CGFloat = 1
        static let opacity: Double = 0.1
    }
    
    enum SubtitleButton {
        static let fontSize: CGFloat = 15
        static let fontWeight: Font.Weight = .regular
    }
    
    enum Chevron {
        static let extendedDegrees: CGFloat = 90
        static let collapsedDegrees: CGFloat = 0
        static let size: CGFloat = 20
        static let animationDuration: TimeInterval = 0.2
    }
}


// MARK: - Preview
#Preview {
    VStack {
        GoalView(
            goalModel: .init(
                        id: UUID(),
                        name: "Senior Developer",
                        steps: [
                            .init(id: UUID(),
                                  title: "Pass Exam",
                                  isCompleted: true,
                                  date: Date()
                                 ),
                            .init(id: UUID(),
                                  title: "Learn data",
                                  isCompleted: false,
                                  date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!
                                 ),
                            .init(id: UUID(),
                                  title: "Task First",
                                  isCompleted: false,
                                  date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!
                                 )
                        ]
            )
        )
    }
    .padding(.horizontal)
}
