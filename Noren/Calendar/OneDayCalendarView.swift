//
//  OneDayCalendarView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct OneDayCalendarView: View {
    @Binding var date: Date

    var body: some View {
        Text("\(date)")
    }
}

struct OneDayCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        OneDayCalendarView(date: .constant(Date()))
    }
}
