//
//  DetailView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @Binding var page: NavigationPage?
    @Binding var date: Date

    var body: some View {
        switch page ?? .calender {
        case .calender:
            Text("ca")
        case .reminder:
            Text("r")
        case .clock:
            Text("cl")
        case .settings:
            Text("s")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(page: .constant(.calender), date: .constant(Date()))
    }
}
