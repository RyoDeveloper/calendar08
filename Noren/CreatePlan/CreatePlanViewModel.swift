//
//  CreatePlanViewModel.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import EventKit
import Foundation

class CreatePlanViewModel: ObservableObject {
    @Published var type: EKEntityType = .event
    // タイトル
    @Published var title = ""
    // 終日
    @Published var isAllDay = false
    // 開始日時
    @Published var start = Date()
    // 終了日時
    @Published var end = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    // カレンダー
    @Published var calendar: EKCalendar?
    // メモ
    @Published var note = ""
    // 日付
    @Published var isDay = false
    // 優先順位
    @Published var priority = 2

    func createPlan(eventKitManager: EventKitManager) {
        let plansTitle = title.split(whereSeparator: \.isNewline)

        if type == .event {
            // イベントの追加
            plansTitle.forEach { title in
                let event = EKEvent(eventStore: eventKitManager.store)
                event.title = String(title)
                event.isAllDay = isAllDay
                event.startDate = start
                event.endDate = end
                event.calendar = calendar ?? eventKitManager.store.defaultCalendarForNewEvents
                event.notes = note
                eventKitManager.createPlan(plan: Plan(event))
            }
        } else if type == .reminder {
            // リマインダーの追加
            plansTitle.forEach { title in
                let reminder = EKReminder(eventStore: eventKitManager.store)
                reminder.title = String(title)
                if isDay && isAllDay {
                    reminder.dueDateComponents = Calendar.current.dateComponents([.calendar, .year, .month, .day], from: start)
                } else if isDay {
                    reminder.dueDateComponents = Calendar.current.dateComponents([.calendar, .year, .month, .day, .hour, .minute], from: start)
                }
                reminder.priority = priority.getPriority()
                reminder.calendar = calendar ?? eventKitManager.store.defaultCalendarForNewReminders()
                reminder.notes = note
                eventKitManager.createPlan(plan: Plan(reminder))
            }
        }
    }
}
