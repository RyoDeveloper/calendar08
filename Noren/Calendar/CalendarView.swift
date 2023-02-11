//
//  CalendarView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

enum CalendarPage {
    case onDay
    case week
}

struct CalendarView: View {
    @EnvironmentObject var eventKitManager: EventKitManager
    @Binding var date: Date
    @State var page = CalendarPage.onDay
    @State var isShowCreatePlanView = false

    var body: some View {
        NavigationStack {
            Group {
                switch page {
                case .onDay:
                    OneDayCalendarView(date: $date)
                case .week:
                    WeekCalendarView(date: $date)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Picker("", selection: $page) {
                        Text("日")
                            .tag(CalendarPage.onDay)
                        Text("週")
                            .tag(CalendarPage.week)
                    }
                    .pickerStyle(.segmented)
                }
                ToolbarItem(placement: .principal) {
                    DatePicker("", selection: $date, displayedComponents: .date)
                        .labelsHidden()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowCreatePlanView = true
                    } label: {
                        Label("新規", systemImage: "plus")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $isShowCreatePlanView, content: {
            CreatePlanView()
        })
        .task {
            print(eventKitManager.requestCalendar())
            print(eventKitManager.requestReminder())
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(date: .constant(Date()))
            .environmentObject(EventKitManager())
    }
}
