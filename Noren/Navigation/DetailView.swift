//
//  DetailView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @Binding var page: NavigationPage?
    @Binding var date: Date

    var body: some View {
        switch page ?? .calender {
        case .calender:
            CalendarView()
        case .reminder:
            ReminderView()
        case .clock:
            ClockView()
        case .settings:
            SettingsView()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(page: .constant(.calender), date: .constant(Date()))
    }
}
