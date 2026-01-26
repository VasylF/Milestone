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
        VStack {
            VStack {
                HStack(spacing: Constants.defaultSpacing) {
                    chevronButton
                    VStack(spacing: Constants.defaultSpacing) {
                        headerView
                        gradientProgressBar
                    }
                }
            }
            .padding(Constants.defaultSpacing)
            if isGoalsListExtended, goalModel.steps.count > 0 {
                dividerLine
                stepsList
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(Color.primary.opacity(0.06), lineWidth: 1)
        )
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.08), radius: 15, x: 0, y: 6)
    }
    
    private var addSubtaskButton: some View {
        Button {
            
        } label: {
            HStack(spacing: 10) {
                Image(systemName: "plus")
                    .frame(width: 15, height: 15)
                Text("Add Subtask")
                    .font(.system(size: Constants.SubtitleButton.fontSize, weight: Constants.SubtitleButton.fontWeight))
                Spacer()
            }
            .foregroundStyle(Color.mainPurple)
        }

    }
    
    private var stepsList: some View {
        VStack(spacing: 7) {
            ForEach(goalModel.steps, id: \.id) { step in
                StepView(step: step)
            }
            addSubtaskButton
                .padding(.horizontal, 12)
                .padding(.top, 10)
                .padding(.bottom, 25)
        }
        .animation(.easeInOut(duration: 1), value: isGoalsListExtended)
        .padding(.horizontal, Constants.defaultSpacing)
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
            Image(systemName: Constants.Chevron.imageName)
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
        HStack(alignment: .firstTextBaseline) {
            Text(goalModel.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            Spacer()
            Menu {
                Button("Edit", action: {})
                Button("Delete",
                       role: .destructive,
                       action: {
                    modelContext.delete(goalModel)
                })
            } label: {
                Image(systemName: "ellipsis")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.mainPurple)
                    .padding(.horizontal, 2)
                    .contentShape(Rectangle())
            }
        }
    }
    
    private var gradientProgressBar: some View {
        GradientProgressBar(completedNumberOfSteps: goalModel.numberOfCompletedSteps, numberOfSteps: goalModel.numberOfSteps)
    }
}

// MARK: - Constants
private enum Constants {
    static let defaultSpacing: CGFloat = 15
    
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
        static let imageName: String = "chevron.right"
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
