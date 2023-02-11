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
            plans = eventKitManager.fetchReminder(start: Date(), end: Date())
            print(plans)
        }
    }
}

struct KanbanReminderView_Previews: PreviewProvider {
    static var previews: some View {
        KanbanReminderView()
            .environmentObject(EventKitManager())
    }
}
