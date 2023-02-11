//
//  CreatePlanView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import EventKit
import SwiftUI

struct CreatePlanView: View {
    @EnvironmentObject var eventKitManager: EventKitManager
    @StateObject var viewModel = CreatePlanViewModel()
    // 親ViewのSheetのフラグ
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $viewModel.type) {
                    Text("イベント")
                        .tag(EKEntityType.event)
                    Text("リマインダー")
                        .tag(EKEntityType.reminder)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                if viewModel.type == .event {
                    // Pickerがイベントの時
                    List {
                        TextField("タイトル", text: $viewModel.title, axis: .vertical)
                        Toggle("終日", isOn: $viewModel.isAllDay)
                        DatePicker("開始", selection: $viewModel.start, displayedComponents: viewModel.isAllDay ? .date : [.date, .hourAndMinute])
                        DatePicker("終了", selection: $viewModel.end, displayedComponents: viewModel.isAllDay ? .date : [.date, .hourAndMinute])
                        Picker("カレンダー", selection: $viewModel.calendar) {
                            ForEach(eventKitManager.store.sources, id: \.self) { sources in
                                Section(sources.title) {
                                    ForEach(Array(sources.calendars(for: .event)), id: \.self) { calendar in
                                        if calendar.allowsContentModifications {
                                            Text(calendar.title)
                                                .tag(calendar as EKCalendar?)
                                        }
                                    }
                                }
                            }
                        }
                        TextField("メモ", text: $viewModel.memo, axis: .vertical)
                    }
                } else {
                    // Pickerがリマインダーの時
                    List {}
                }
            }
            .background(Color(.systemGroupedBackground))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル", role: .destructive) {
                        dismiss()
                    }
                    .buttonStyle(.borderless)
                }

                ToolbarItem(placement: .primaryAction) {
                    Button("追加") {
                        viewModel.createPlan(eventKitManager: eventKitManager)
                        dismiss()
                    }
                    .disabled(viewModel.title.split(whereSeparator: \.isWhitespace).count == 0)
                }
            }
            .navigationTitle("\(viewModel.title.split(whereSeparator: \.isWhitespace).count)個の" + viewModel.type.getName())
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            viewModel.calendar = eventKitManager.store.defaultCalendarForNewEvents
        }
    }
}

struct CreatePlanView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlanView()
    }
}
