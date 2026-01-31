//
//  Font.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 31.01.2026.
//

import SwiftUI

extension Font {
    static func inter(
        _ weight: CustomFont.Inter,
        size: Size,
        relativeTo textStyle: Font.TextStyle? = .body
    ) -> Font {
        if let textStyle {
            // Scales with Dynamic Type
            return .custom(weight.rawValue, size: size.rawValue, relativeTo: textStyle)
        } else {
            return .custom(weight.rawValue, size: size.rawValue)
        }
    }
}
