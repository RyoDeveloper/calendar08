//
//  Int.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import Foundation

extension Int {
    // https://developer.apple.com/documentation/eventkit/ekreminderpriority
    /// リマインダーの優先順位を返す
    func getPriority() -> IntegerLiteralType {
        if self == 1 {
            return 9
        } else if self == 2 {
            return 5
        } else if self == 3 {
            return 1
        } else {
            return 0
        }
    }
}
