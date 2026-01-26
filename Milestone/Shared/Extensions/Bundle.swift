//
//  Bundle.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 26.01.2026.
//

import Foundation


extension Bundle {
    static var version: String? {
        main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    static var build: String? {
        main.infoDictionary?["CFBundleVersion"] as? String
    }
}
