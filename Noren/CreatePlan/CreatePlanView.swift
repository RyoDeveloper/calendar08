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
                        .task {
                            viewModel.calendar = eventKitManager.store.defaultCalendarForNewEvents
                        }
                        TextField("メモ", text: $viewModel.note, axis: .vertical)
                    }
                } else {
                    // Pickerがリマインダーの時
                    List {
                        TextField("タイトル", text: $viewModel.title, axis: .vertical)
                        Toggle("日付", isOn: $viewModel.isDay)
                        if viewModel.isDay {
                            Toggle("終日", isOn: $viewModel.isAllDay)
                            DatePicker("日付", selection: $viewModel.start, displayedComponents: viewModel.isAllDay ? .date : [.date, .hourAndMinute])
                        }
                        HStack {
                            Text("優先順位")
                            Spacer()
                            ForEach(0 ..< 3) { index in
                                Button {
                                    // 選択済みをもう一度タップで初期化
                                    if viewModel.priority == index + 1 {
                                        viewModel.priority = 0
                                    } else {
                                        viewModel.priority = index + 1
                                    }
                                } label: {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(index < viewModel.priority ? Color.accentColor : Color(.quaternaryLabel))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        Picker("リスト", selection: $viewModel.calendar) {
                            ForEach(eventKitManager.store.sources, id: \.self) { sources in
                                Section(sources.title) {
                                    ForEach(Array(sources.calendars(for: .reminder)), id: \.self) { reminder in
                                        if reminder.allowsContentModifications {
                                            Text(reminder.title)
                                                .tag(reminder as EKCalendar?)
                                        }
                                    }
                                }
                            }
                        }
                        .task {
                            viewModel.calendar = eventKitManager.store.defaultCalendarForNewReminders()
                        }
                        TextField("メモ", text: $viewModel.note, axis: .vertical)
                    }
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
                    .disabled(viewModel.title.split(whereSeparator: \.isNewline).count == 0)
                }
            }
            .navigationTitle("\(viewModel.title.split(whereSeparator: \.isNewline).count)個の" + viewModel.type.getName())
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CreatePlanView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlanView()
            .environmentObject(EventKitManager())
    }
}
