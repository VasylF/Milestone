//
//  DateView.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 31.01.2026.
//

import SwiftUI

struct DateView: View {
    var state: DateViewState
    var isCompleted: Bool
    var onAction: () -> Void
    
    var body: some View {
        Button {
            onAction()
        } label: {
            statusView
        }
    }
    
    private var statusView: some View {
        HStack(spacing: Constants.spacing) {
            Image(.calendar)
                .frame(size: Constants.size)
            Text(title)
                .font(.inter(.semiBold, size: .lMedium))
        }
        .padding(.horizontal, Constants.contentHPadding)
        .padding(.vertical, Constants.contentVPadding)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                .fill(color.opacity(Constants.contentBackgroundOpacity))
                .frame(height: Constants.contentHeight)
        )
        .foregroundStyle(color)
    }
    
    private var title: String {
        switch state {
            case .overdue:
                return Strings.overdue
            case .today:
                return Strings.today
            case .noDate:
                return Strings.noDate
            case .date(let date):
                return date.conver(to: .MMMd)
        }
    }
    
    private var color: Color {
        guard isCompleted == false else { return .mediumGray }
        
        switch state {
            case .overdue:
                return .mred
            case .today, .date:
                return .mainPurple
            case .noDate:
                return .mediumGray
        }
    }
}

// MARK: - Constants
private enum Strings {
    static let overdue: String = "Overdue"
    static let today: String = "Today"
    static let noDate: String = "Add Date"
}

// MARK: - Constants
private enum Constants {
    static let size: CGFloat = 12
    static let spacing: CGFloat = 5
    static let contentVPadding: CGFloat = 4
    static let contentHPadding: CGFloat = 9
    static let cornerRadius: CGFloat = 8
    static let contentHeight: CGFloat = 26
    static let contentBackgroundOpacity: Double = 0.08
}

// MARK: - Preview
#Preview {
    VStack(alignment: .leading, spacing: 10) {
        DateView(state: .overdue, isCompleted: true) { }
        DateView(state: .overdue, isCompleted: false) { }
        DateView(state: .today, isCompleted: true) { }
        DateView(state: .noDate, isCompleted: false) { }
        DateView(state: .date(Date()), isCompleted: false) { }
    }
}
