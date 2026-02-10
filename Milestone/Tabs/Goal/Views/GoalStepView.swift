//
//  GoalStepView.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 06.02.2026.
//

import SwiftUI

struct GoalStepView: View {
    let stepModel: StepModel
    
    @State private var isShowingDatePicker = false
    @State private var selectedDate: Date = Date()
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        HStack(alignment: .top) {
            statusButton
            stepName
            Spacer()
            dateView
        }
        .padding(.horizontal, Constants.padding)
    }

    private var statusButton: some View {
        Button {
            stepModel.isCompleted.toggle()
        } label: {
            Image(stepModel.isCompleted ? .checkmarkDone : .checkmarkUndone)
        }
        .frame(size: Constants.StateButton.size)
    }
    
    private var stepName: some View {
        Text(stepModel.title)
            .font(.inter(.medium, size: .medium))
            .foregroundStyle(stepModel.isCompleted ? .mediumGray : .darkBlue)
            .strikethrough(stepModel.isCompleted)
    }
    
    private var dateView: some View {
        DateView(state: convertToDateViewState(stepModel.date), isCompleted: stepModel.isCompleted) {
            selectedDate = stepModel.date ?? Date()
            isShowingDatePicker = true
        }
        .disabled(stepModel.isCompleted)
        .popover(isPresented: $isShowingDatePicker, arrowEdge: .top) {
            VStack(alignment: .leading,
                   spacing: Constants.DatePicker.spacing) {
                DatePicker(
                    Strings.dueDate,
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)

                HStack {
                    Spacer()
                    Button(Strings.done) {
                        isShowingDatePicker = false
                        if selectedDate != stepModel.date {
                            stepModel.date = selectedDate
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .presentationDetents([.medium])
        }
    }
}

// MARK: - Constants
private enum Constants {
    static let padding: CGFloat = 8
    
    enum StateButton {
        static let size: CGFloat = 20
    }
    enum DatePicker {
        static let spacing: CGFloat = 12
    }
}

// MARK: - Strings
private enum Strings {
    static let done = "Done"
    static let dueDate = "To Do Date"
}

// MARK: - Preview
#Preview {
    // Provide a simple mock StepModel for previewing
    let sample = StepModel(
        id: UUID(),
        title: "Design screens",
        isCompleted: false,
        date: Calendar.current.date(byAdding: .day, value: 3, to: Date())
    )
    GoalStepView(stepModel: sample)
        .padding()
}

