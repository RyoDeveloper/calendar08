//
//  ReminderView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct ReminderView: View {
    @EnvironmentObject var eventKitManager: EventKitManager

    var body: some View {
        VStack {
            KanbanReminderView()
        }
        .task {
            print(eventKitManager.requestReminder())
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
            .environmentObject(EventKitManager())
    }
}
