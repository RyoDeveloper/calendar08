//
//  ReminderView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

enum ReminderPage {
    case kanban
    case vertical
}

struct ReminderView: View {
    @EnvironmentObject var eventKitManager: EventKitManager
    @State var page = ReminderPage.kanban
    @State var isShowCreatePlanView = false

    var body: some View {
            Group {
                switch page {
                case .kanban:
                    KanbanReminderView()
                case .vertical:
                    VerticalReminderView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Picker("", selection: $page) {
                        Text("カンバン")
                            .tag(ReminderPage.kanban)
                        Text("縦")
                            .tag(ReminderPage.vertical)
                    }
                    .pickerStyle(.segmented)
                }
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
        NavigationStack {
            ReminderView()
                .environmentObject(EventKitManager())
        }
    }
}
