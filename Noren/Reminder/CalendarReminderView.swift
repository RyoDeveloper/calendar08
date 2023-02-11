//
//  CalendarReminderView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import EventKit
import SwiftUI

struct CalendarReminderView: View {
    @EnvironmentObject var eventKitManager: EventKitManager
    @State var calendar: EKCalendar
    // 期限切れ
    @State var expiredPlans: [Plan] = []
    // 今日
    @State var todayPlans: [Plan] = []
    // 明日
    @State var tomorrowPlans: [Plan] = []
    // 明後日
    @State var dayAfterTomorrowPlans: [Plan] = []
    // それ以降
    @State var onwardsPlans: [Plan] = []

    var body: some View {
        VStack(alignment: .leading) {
            Text(calendar.title)
                .font(.title)
                .fontWeight(.semibold)
            Section("期限切れ") {
                ForEach(expiredPlans, id: \.self) { expiredPlan in
                    PlanView(plan: expiredPlan)
                }
            }
            Section("今日") {
                ForEach(todayPlans, id: \.self) { plan in
                    PlanView(plan: plan)
                }
            }
            Section("明日") {
                ForEach(tomorrowPlans, id: \.self) { expiredPlan in
                    PlanView(plan: expiredPlan)
                }
            }
            Section("明後日") {
                ForEach(dayAfterTomorrowPlans, id: \.self) { plan in
                    PlanView(plan: plan)
                }
            }
            Section("以降") {
                ForEach(onwardsPlans, id: \.self) { expiredPlan in
                    PlanView(plan: expiredPlan)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
        .background(Color(calendar.cgColor).opacity(0.1))
        .cornerRadius(10)
        .task {
            expiredPlans = eventKitManager.fetchReminder(start: Calendar.current.date(byAdding: .year, value: -1, to: Date())!, end: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, calendar: [calendar])
            todayPlans = eventKitManager.fetchReminder(start: Date(), end: Date(), calendar: [calendar])
            tomorrowPlans = eventKitManager.fetchReminder(start: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, end: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, calendar: [calendar])
            dayAfterTomorrowPlans = eventKitManager.fetchReminder(start: Calendar.current.date(byAdding: .day, value: 2, to: Date())!, end: Calendar.current.date(byAdding: .day, value: 2, to: Date())!, calendar: [calendar])
            onwardsPlans = eventKitManager.fetchReminder(start: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, end: Calendar.current.date(byAdding: .year, value: 1, to: Date())!, calendar: [calendar])
        }
    }
}

struct CalendarReminderView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarReminderView(calendar: EventKitManager().store.defaultCalendarForNewReminders()!)
            .environmentObject(EventKitManager())
    }
}
