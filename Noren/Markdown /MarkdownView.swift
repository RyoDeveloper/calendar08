//
//  MarkdownView.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI
import RDMarkdownKit

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
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(Color(.systemBackground))
                    .frame(height: 1)
                Markdown($text)
            }
            
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
