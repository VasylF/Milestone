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
    static let defaultGradient: LinearGradient = .init(
        stops: [
            .init(color: Color.purple, location: 0.0),
            .init(color: Color.blue, location: 1.0)
        ],
        startPoint: .leading,
        endPoint: .trailing
    )
    static let inactiveGradient: LinearGradient = .init(
        stops: [
            .init(color: Color.mainGray, location: 0.0),
            .init(color: Color.mainGray, location: 1.0)
        ],
        startPoint: .leading,
        endPoint: .trailing
    )
}
