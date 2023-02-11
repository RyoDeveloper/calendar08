//
//  EventKitManager.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import EventKit
import Foundation

class EventKitManager: ObservableObject {
    var store = EKEventStore()
    
    /// カレンダーへのアクセスを要求
    func requestCalendar() -> Bool {
        Task {
            do {
                // カレンダーへのアクセスを要求
                try await store.requestAccess(to: .event)
            } catch {
                print(error.localizedDescription)
            }
        }
        // イベントへの認証ステータス
        let status = EKEventStore.authorizationStatus(for: .event)
        
        switch status {
        case .notDetermined:
            // カレンダーへのアクセスする権限が選択されていません。
            return false
        case .restricted:
            // カレンダーへのアクセスする権限がありません。
            return false
        case .denied:
            // カレンダーへのアクセスが明示的に拒否されています。
            return false
        case .authorized:
            // カレンダーへのアクセスが許可されています。
            return true
        @unknown default:
            // @unknown default
            return false
        }
    }
    
    /// リマインダーへのアクセスを要求
    func requestReminder() -> Bool {
        Task {
            do {
                // リマインダーへのアクセスを要求
                try await store.requestAccess(to: .reminder)
            } catch {
                print(error.localizedDescription)
            }
        }
        // リマインダーへの認証ステータス
        let status = EKEventStore.authorizationStatus(for: .reminder)
        
        switch status {
        case .notDetermined:
            // リマインダーへのアクセスする権限が選択されていません。
            return false
        case .restricted:
            // リマインダーへのアクセスする権限がありません。
            return false
        case .denied:
            // リマインダーへのアクセスが明示的に拒否されています。
            return false
        case .authorized:
            // リマインダーへのアクセスが許可されています。
            return true
        @unknown default:
            // @unknown default
            return false
        }
    }
    
    /// イベントの取得(開始日と終了日の指定)
    func fetchEvent(start: Date, end: Date) -> [Plan] {
        var events: [Plan] = []
        // 開始日コンポーネントの作成
        // 指定した日付の0:00:0
        let start = Calendar.current.startOfDay(for: start)
        // 終了日コンポーネントの作成
        // 指定した日付の23:59:1
        let end = Calendar.current.date(bySettingHour: 23, minute: 59, second: 1, of: end)
        // イベントストアのインスタンスメソッドから述語を作成
        var predicate: NSPredicate?
        if let end {
            predicate = store.predicateForEvents(withStart: start, end: end, calendars: nil)
        }
        // 述語に一致する全てのイベントを取得
        if let predicate {
            store.events(matching: predicate).forEach { event in
                events.append(Plan(event))
            }
        }
        return events
    }
    
    // イベントの取得(開始日1日の指定)
    func fetchEvent(start: Date) -> [Plan] {
        fetchEvent(start: start, end: start)
    }
}
