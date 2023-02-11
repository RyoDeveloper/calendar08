//
//  CreatePlanViewModel.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import EventKit
import Foundation

class CreatePlanViewModel: ObservableObject {
    @Published var type: EKEntityType = .event
    // タイトル
    @Published var title = ""
    // 終日
    @Published var isAllDay = false
    // 開始日時
    @Published var start = Date()
    // 終了日時
    @Published var end = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    // カレンダー
    @Published var calendar: EKCalendar?
    // メモ
    @Published var memo = ""
}
