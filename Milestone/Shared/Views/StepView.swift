//
//  StepView.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 24.01.2026.
//

import Foundation
import SwiftUI

struct StepView: View {
    let step: StepModel

    @State private var isShowingDatePicker = false
    @State private var selectedDate: Date = Date()

    var body: some View {
        HStack(spacing: Constants.Layout.hStackSpacing) {
            Button {
                step.isCompleted.toggle()
            } label: {
                Image(systemName: step.isCompleted ? Constants.SFSymbols.completed : Constants.SFSymbols.incomplete)
                    .font(.system(size: Constants.Icon.fontSize, weight: Constants.Icon.fontWeight))
                    .foregroundStyle(step.isCompleted ? AnyShapeStyle(.mainPurple) : AnyShapeStyle(Color.secondary.opacity(Constants.Icon.incompleteIconOpacity)))
            }

            Text(step.title)
                .font(.system(size: Constants.Title.fontSize, weight: Constants.Title.fontWeight))
                .strikethrough(step.isCompleted)
                .foregroundStyle(step.isCompleted ? .secondary : .primary)
                .truncationMode(.tail)

            Spacer(minLength: Constants.Layout.spacerMinLength)

            let isOverdue = step.date < Calendar.current.startOfDay(for: Date()) && !step.isCompleted

            HStack(spacing: Constants.DatePill.spacing) {
                Image(systemName: Constants.SFSymbols.calendar)
                    .font(.system(size: Constants.DatePill.FontSpec.size, weight: Constants.DatePill.FontSpec.weight))
                Text(step.date.toRelativeDate())
                    .font(.system(size: Constants.DatePill.FontSpec.size, weight: Constants.DatePill.FontSpec.weight))
            }
            .padding(.horizontal, Constants.DatePill.horizontalPadding)
            .padding(.vertical, Constants.DatePill.verticalPadding)
            .background(
                Capsule(style: .continuous)
                    .fill((isOverdue ? AnyShapeStyle(Color.red.opacity(Constants.DatePill.tintOpacity)) : AnyShapeStyle(.tint.opacity(Constants.DatePill.tintOpacity))))
            )
            .foregroundStyle(isOverdue ? AnyShapeStyle(Color.red) : AnyShapeStyle(.tint))
            .onTapGesture {
                selectedDate = step.date
                isShowingDatePicker = true
            }
            .popover(isPresented: $isShowingDatePicker, arrowEdge: .top) {
                VStack(alignment: .leading, spacing: 12) {
                    DatePicker(
                        Constants.Strings.dueDate,
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)

                    HStack {
                        Spacer()
                        Button(Constants.Strings.done) {
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
        .padding(.horizontal, Constants.Layout.containerHorizontalPadding)
        .padding(.vertical, Constants.Layout.verticalPadding)
        .background(
            RoundedRectangle(cornerRadius: Constants.Container.cornerRadius, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: Constants.Container.cornerRadius, style: .continuous)
                .stroke(Color.primary.opacity(Constants.Container.borderOpacity), lineWidth: Constants.Container.borderLineWidth)
        )
        .shadow(color: Color.black.opacity(Constants.Container.shadowOpacity), radius: Constants.Container.shadowRadius, x: Constants.Container.shadowOffsetX, y: Constants.Container.shadowOffsetY)
        .onAppear {
            selectedDate = step.date
        }
    }
}


// MARK: - Constants
private enum Constants {
    // Layout & spacing
    enum Layout {
        static let hStackSpacing: CGFloat = 5
        static let verticalPadding: CGFloat = 10
        static let spacerMinLength: CGFloat = 8
        static let containerHorizontalPadding: CGFloat = 14
    }

    // Leading status icon
    enum Icon {
        static let fontSize: CGFloat = 18
        static let fontWeight: Font.Weight = .semibold
        static let incompleteIconOpacity: Double = 0.6
    }

    // Title text
    enum Title {
        static let fontSize: CGFloat = 17
        static let fontWeight: Font.Weight = .regular
    }

    // Date pill (calendar + date text)
    enum DatePill {
        static let spacing: CGFloat = 6
        static let horizontalPadding: CGFloat = 10
        static let verticalPadding: CGFloat = 6
        static let tintOpacity: Double = 0.12

        enum FontSpec {
            static let size: CGFloat = 13
            static let weight: Font.Weight = .semibold
        }
    }

    // Container background, border, and shadow
    enum Container {
        static let cornerRadius: CGFloat = 16
        static let borderOpacity: Double = 0.06
        static let borderLineWidth: CGFloat = 1
        static let shadowOpacity: Double = 0.04
        static let shadowRadius: CGFloat = 8
        static let shadowOffsetX: CGFloat = 0
        static let shadowOffsetY: CGFloat = 2
    }

    // System image names
    enum SFSymbols {
        static let completed = "checkmark.circle.fill"
        static let incomplete = "circle"
        static let calendar = "calendar"
    }

    // User-facing strings
    enum Strings {
        static let dueDate = "Due Date"
        static let done = "Done"
    }
}


// MARK: - Preview
#Preview {
    ScrollView {
        VStack(alignment: .leading, spacing: 12) {
            StepView(step: .init(id: UUID(), title: "User testing", isCompleted: false, date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!))
            StepView(step: .init(id: UUID(), title: "Design review", isCompleted: true, date: Date()))
            StepView(step: .init(id: UUID(), title: "Prepare launch notes", isCompleted: false, date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!))
            StepView(step: .init(id: UUID(), title: "Prepare launch notes", isCompleted: false, date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!))
        }
        .padding(16)
    }
}

