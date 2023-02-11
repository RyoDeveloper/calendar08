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
    @State var isShowCreatePlanView = false

    var body: some View {
        NavigationStack {
            OneDayCalendarView(date: $date)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isShowCreatePlanView = true
                        } label: {
                            Label("新規", systemImage: "plus")
                        }
                    }
                }
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
