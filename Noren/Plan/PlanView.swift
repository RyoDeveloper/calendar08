//
//  PlanView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct PlanView: View {
    @State var plan: Plan

    var body: some View {
        Group {
            if let event = plan.event {
                HStack {
                    Image(systemName: "poweron")
                        .fontWeight(.bold)
                        .foregroundColor(plan.getCalendarColor())
                    Text(event.title)
                }
            } else if let reminder = plan.reminder {
                HStack {
                    Image(systemName: "circle")
                        .fontWeight(.bold)
                        .foregroundColor(plan.getCalendarColor())
                    Text(reminder.title)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView(plan: Plan(EventKitManager()))
    }
}
