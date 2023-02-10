//
//  SideberView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

enum NavigationPage: CaseIterable {
    case calender
    case reminder
    case clock
    case settings
}

struct SideberView: View {
    @Binding var page: NavigationPage?
    @Binding var date: Date

    var body: some View {
        List(selection: $page) {
            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(.graphical)
            NavigationLink(value: NavigationPage.calender) {
                Label("カレンダー", systemImage: "calendar")
            }
            NavigationLink(value: NavigationPage.reminder) {
                Label("リマインダー", systemImage: "checkmark.circle")
            }
            NavigationLink(value: NavigationPage.clock) {
                Label("時計", systemImage: "clock")
            }
            NavigationLink(value: NavigationPage.settings) {
                Label("設定", systemImage: "gearshape")
            }
        }
    }
}

struct SideberView_Previews: PreviewProvider {
    static var previews: some View {
        SideberView(page: .constant(.calender), date: .constant(Date()))
    }
}
