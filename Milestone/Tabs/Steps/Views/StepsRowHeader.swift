//
//  StepsRowHeader.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 03.02.2026.
//

import SwiftUI

struct StepsRowHeader: View {
    let numberOfItems: Int
    let type: HeaderType
    
    var body: some View {
        HStack(spacing: Constants.dotSize) {
            dotView
            title
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(type.color)
    }
    
    private var title: some View {
        Text("\(type.title) (\(numberOfItems))")
            .font(.inter(.bold, size: .lMedium))
    }
    
    private var dotView: some View {
        Circle()
            .frame(size: Constants.dotSize)
    }
}

// MARK: - StepsRowHeaderType
extension StepsRowHeader {
    enum HeaderType {
        case overdue
        case today
        case upcoming
        case noDueDate
        
        var color: Color {
            switch self {
                case .overdue:
                    return .mred
                case .upcoming, .today:
                    return .mainPurple
                case .noDueDate:
                    return .mediumGray
            }
        }
        
        var title: String {
            switch self {
                case .overdue:
                    return Strings.overdue
                case .today:
                    return Strings.today
                case .upcoming:
                    return Strings.upcoming
                case .noDueDate:
                    return Strings.noDueDate
            }
        }
    }
}

// MARK: - Strings
private enum Strings {
    static let overdue = "OVERDUE"
    static let today = "TODAY"
    static let upcoming = "UPCOMING"
    static let noDueDate = "NO DO DATE"
}

// MARK: - Constants
private enum Constants {
    static let spacing: CGFloat = 8
    static let dotSize: CGFloat = 8
}

// MARK: - Constants
#Preview {
    VStack(spacing: 10) {
        StepsRowHeader(numberOfItems: 12, type: .overdue)
        StepsRowHeader(numberOfItems: 5, type: .today)
        StepsRowHeader(numberOfItems: 1, type: .upcoming)
        StepsRowHeader(numberOfItems: 12, type: .noDueDate)
    }
    .padding()
}
