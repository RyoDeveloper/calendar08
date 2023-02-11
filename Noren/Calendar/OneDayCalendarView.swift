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
    @State var plans: [Plan] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(plans, id: \.self) { plan in
                    PlanView(plan: plan)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .task {
            plans = eventKitManager.fetchEvent(start: date)
        }
        .onChange(of: date) { newValue in
            plans = eventKitManager.fetchEvent(start: newValue)
        }
    }
}

struct OneDayCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        OneDayCalendarView(date: .constant(Date()), plans: [])
            .environmentObject(EventKitManager())
    }
}
