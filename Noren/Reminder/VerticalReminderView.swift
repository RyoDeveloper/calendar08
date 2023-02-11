//
//  VerticalReminderView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct VerticalReminderView: View {
    @EnvironmentObject var eventKitManager: EventKitManager
    @State var columns = [GridItem(.adaptive(minimum: 300), alignment: .top)]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(eventKitManager.store.sources, id: \.self) { sources in
                    ForEach(Array(sources.calendars(for: .reminder)), id: \.self) { reminder in
                        CalendarReminderView(calendar: reminder)
                    }
                }
            }
            .padding()
        }
    }
}

struct VerticalReminderView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalReminderView()
    }
}
