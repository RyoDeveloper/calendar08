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
}
