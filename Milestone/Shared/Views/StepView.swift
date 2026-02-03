//
//  StepView.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 24.01.2026.
//

import Foundation
import SwiftUI
import SwiftData

private typealias C = Constants

struct StepView: View {
    let step: StepModel

    @State private var isShowingDatePicker = false
    @State private var selectedDate: Date = Date()
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        HStack(alignment: .top, spacing: C.spacing) {
            statusButton
            detailesView
            moreButton
        }
        .padding(C.Container.padding)
        .background(
            RoundedRectangle(cornerRadius: C.Container.cornerRadius, style: .continuous)
                .fill(.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: C.Container.cornerRadius, style: .continuous)
                .stroke(Color.softGray, lineWidth: C.Container.borderLineWidth)
        )
        .shadow(color: Color.mainGray.opacity(C.Container.shadowOpacity),
                radius: Constants.Container.cornerRadius,
                x: C.Container.shadowOffsetX,
                y: C.Container.shadowOffsetY)
        .onAppear {
            selectedDate = step.date ?? Date()
        }
    }
    
    private var statusButton: some View {
        Button {
            step.isCompleted.toggle()
        } label: {
            Image(step.isCompleted ? .checkmarkDone : .checkmarkUndone)
        }
        .frame(size: C.StateButton.size)
    }
    
    private var detailesView: some View {
        VStack(alignment: .leading,
               spacing: C.DetailsView.spacing) {
            Text(step.title)
                .font(.inter(.medium, size: .medium))
                .foregroundStyle(step.isCompleted ? .mediumGray : .darkBlue)
                .strikethrough(step.isCompleted)
                .padding(.bottom, C.DetailsView.titleBottomPaddign)
            stepSubtitle
            dateView
        }
               .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var stepSubtitle: some View {
        HStack(spacing: C.StepSubtitle.spacing) {
            Image(.folder)
                .frame(size: C.StepSubtitle.imageSize)
            Text(step.goalName ?? Strings.noGoal)
                .font(.inter(step.hasGoal ? .regular : .italic, size: .lMedium))
                
        }
        .foregroundStyle(step.hasGoal ? .mainGray : .mediumGray)
    }
    
    private var dateView: some View {
        DateView(state: step.convertToState(), isCompleted: step.isCompleted) {
            selectedDate = step.date ?? Date()
            isShowingDatePicker = true
        }
        .disabled(step.isCompleted)
        .popover(isPresented: $isShowingDatePicker, arrowEdge: .top) {
            VStack(alignment: .leading, spacing: C.DatePicker.spacing) {
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
                        if selectedDate != step.date {
                            step.date = selectedDate
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .presentationDetents([.medium])
        }
    }
    
    private var moreButton: some View {
        Menu {
            Button(Strings.edit, action: {
                // todo: show edit step screen
            })
            Button(Strings.delete,
                   role: .destructive,
                   action: {
                modelContext.delete(step)
            })
        } label: {
            Image(.more)
        }
        .frame(size: C.More.size)
    }
}

// MARK: - StepModel Extension
private extension StepModel {
    func convertToState() -> DateViewState {
        guard let date else {
            return .noDate
        }
        
        if date.isToday {
            return .today
        } else if date.isOverdueByDay {
            return .overdue
        } else {
            return .date(date)
        }
    }
}

// MARK: - Strings
private enum Strings {
    static let done = "Done"
    static let dueDate = "Due Date"
    static let noGoal = "No goal"
    static let edit = "Edit"
    static let delete = "Delete"
}

// MARK: - Constants
private enum Constants {
    static let spacing: CGFloat = 12
    
    enum Container {
        static let cornerRadius: CGFloat = 12
        static let padding: CGFloat = 17
        static let borderLineWidth: CGFloat = 1
        static let shadowOpacity: CGFloat = 0.4
        static let shadowOffsetX: CGFloat = 0
        static let shadowOffsetY: CGFloat = 2
    }
    
    enum More {
        static let size: CGFloat = 32
    }
    
    enum DatePicker {
        static let spacing: CGFloat = 12
    }
    
    enum StateButton {
        static let size: CGFloat = 20
    }
    
    enum DetailsView {
        static let spacing: CGFloat = 10
        static let titleBottomPaddign: CGFloat = 4
    }
    
    enum StepSubtitle {
        static let spacing: CGFloat = 6
        static let imageSize: CGFloat = 12
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        VStack(alignment: .leading, spacing: 20) {
            StepView(step: .init(id: UUID(), title: "User testing", isCompleted: false, date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, goalName: "T4 Grade"))
            StepView(step: .init(id: UUID(), title: "Design review", isCompleted: true, date: Date()))
            StepView(step: .init(id: UUID(), title: "Prepare launch notes", isCompleted: false, date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!))
            StepView(step: .init(id: UUID(), title: "Prepare launch notes", isCompleted: false, date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!))
        }
        .padding(16)
    }
    .background(.darkBlue.opacity(0.05))
}

