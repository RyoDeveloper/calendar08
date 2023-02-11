//
//  KanbanReminderView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct KanbanReminderView: View {
    @EnvironmentObject var eventKitManager: EventKitManager

    var body: some View {
        ScrollView(showsIndicators: false) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(eventKitManager.store.sources, id: \.self) { sources in
                        ForEach(Array(sources.calendars(for: .reminder)), id: \.self) { reminder in
                            CalendarReminderView(calendar: reminder)
                                .frame(width: 300)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct KanbanReminderView_Previews: PreviewProvider {
    static var previews: some View {
        KanbanReminderView()
            .environmentObject(EventKitManager())
    }
}
