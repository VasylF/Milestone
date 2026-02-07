//
//  GlobalConstants.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 02.02.2026.
//

import Foundation
import SwiftUI

typealias GC = GlobalConstants

enum GlobalConstants {
    static let hPadding: CGFloat = 17
    static let activeGradient: LinearGradient = .init(
        stops: [
            .init(color: Color.purple, location: 0.0),
            .init(color: Color.blue, location: 1.0)
        ],
        startPoint: .leading,
        endPoint: .trailing
    )
    static let inactiveGradient: LinearGradient = .init(
        stops: [
            .init(color: Color(red: 0.62, green: 0.69, blue: 1.0), location: 0.0),
            .init(color: Color(red: 0.98, green: 0.73, blue: 0.98), location: 1.0)
        ],
        startPoint: .leading,
        endPoint: .trailing
    )
}
