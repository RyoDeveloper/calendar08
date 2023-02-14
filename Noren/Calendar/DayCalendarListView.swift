//
//  DayCalendarListView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct DayCalendarListView: View {
    @EnvironmentObject var eventKitManager: EventKitManager
    @Binding var date: Date
    @State var plans: [Plan] = []

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(plans, id: \.self) { plan in
                PlanView(plan: plan)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .task {
            plans = eventKitManager.fetchEventAndReminder(start: date)
        }
        .onChange(of: date) { newValue in
            plans = eventKitManager.fetchEventAndReminder(start: newValue)
        }
    }
}

struct DayCalendarListView_Previews: PreviewProvider {
    static var previews: some View {
        DayCalendarListView(date: .constant(Date()), plans: [Plan(EventKitManager())])
            .environmentObject(EventKitManager())
    }
}
