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
    @State var isShowCreatePlanView = false

    var body: some View {
        VStack {
            KanbanReminderView()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isShowCreatePlanView = true
                } label: {
                    Label("新規", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $isShowCreatePlanView, content: {
            CreatePlanView()
        })
        .navigationBarTitleDisplayMode(.inline)
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
