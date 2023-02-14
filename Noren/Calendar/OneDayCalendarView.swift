//
//  OneDayCalendarView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct OneDayCalendarView: View {
    @EnvironmentObject var eventKitManager: EventKitManager
    @Binding var date: Date
    @State var note = ""

    var body: some View {
        HStack {
            ScrollView {
                DayCalendarListView(date: $date)
                    .padding()
            }
            Divider()
            MarkdownView(text: $note)
                .onChange(of: note) { newValue in
                    let noteEvent = eventKitManager.fetchNote(date: date)
                    noteEvent.notes = newValue
                    eventKitManager.createNote(event: noteEvent)
                }
        }
        .task {
            note = eventKitManager.fetchNote(date: date).notes ?? ""
        }
        .onChange(of: date) { newValue in
            note = eventKitManager.fetchNote(date: date).notes ?? ""
        }
    }
}

struct OneDayCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        OneDayCalendarView(date: .constant(Date()))
            .environmentObject(EventKitManager())
    }
}
