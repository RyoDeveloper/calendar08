//
//  CalendarView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var eventKitManager: EventKitManager
    @Binding var date: Date

    var body: some View {
        OneDayCalendarView(date: $date)
            .task {
                print(eventKitManager.requestCalendar())
                print(eventKitManager.requestReminder())
            }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(date: .constant(Date()))
    }
}
