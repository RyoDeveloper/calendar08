//
//  Plan.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import EventKit
import Foundation

struct Plan: Hashable {
    var event: EKEvent?
    var reminder: EKReminder?
    var date: Date?

    init() {}

    init(_ event: EKEvent) {
        self.event = event
        self.reminder = nil
        self.date = event.startDate
    }

    init(_ reminder: EKReminder) {
        self.reminder = reminder
        self.event = nil
        self.date = reminder.dueDateComponents?.date
    }
}
