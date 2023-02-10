//
//  ContentView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var page: NavigationPage? = NavigationPage.calender
    @State var date = Date()

    var body: some View {
        NavigationSplitView {
            SideberView(page: $page, date: $date)
        } detail: {
            DetailView(page: $page, date: $date)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
