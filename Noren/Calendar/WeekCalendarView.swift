//
//  WeekCalendarView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct WeekCalendarView: View {
    @EnvironmentObject var eventKitManager: EventKitManager
    @Binding var date: Date

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(0 ... 6, id: \.self) { i in
                    Text(Calendar.current.date(byAdding: .day, value: i, to: date)!.getd())
                        .foregroundColor(Calendar.current.isDate(Calendar.current.date(byAdding: .day, value: i, to: date)!, equalTo: Date(), toGranularity: .day) ? .white : .primary)
                        .padding()
                        .background {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Calendar.current.isDate(Calendar.current.date(byAdding: .day, value: i, to: date)!, equalTo: Date(), toGranularity: .day) ? .accentColor : .clear)
                                .font(.largeTitle)
                        }
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
            ScrollView {
                HStack {
                    ForEach(0 ... 6, id: \.self) { i in
                        DayCalendarListView(date: .constant(Calendar.current.date(byAdding: .day, value: i, to: date)!))
                    }
                }
                .padding()
            }
        }
    }
}

struct WeekCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        WeekCalendarView(date: .constant(Date()))
            .environmentObject(EventKitManager())
    }
}
