//
//  MarkdownView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

enum MarkdownPage {
    case text
    case markdown
}

struct MarkdownView: View {
    @Binding var text: String
    @State var page = MarkdownPage.text

    var body: some View {
        TabView(selection: $page) {
            TextEditor(text: $text)
                .tabItem {
                    Label("エディター", systemImage: "square.and.pencil")
                }
            Text(text)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .tabItem {
                    Label("プレビュー", systemImage: "number")
                }
        }
    }
}

struct MarkdownView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownView(text: .constant("text"))
    }
}
