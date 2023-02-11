//
//  EKEntityType.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import Foundation
import EventKit

extension EKEntityType {
    func getName() -> String {
        switch self {
        case .event:
            return "イベント"
        case .reminder:
            return "リマインダー"
        @unknown default:
            return ""
        }
    }
}
