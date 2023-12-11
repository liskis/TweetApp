//
//  ContentView.swift
//  TweetApp
//
//  Created by 渡辺健輔 on 2023/12/09.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    var body: some View {
        TextField("", text: $text, axis: .vertical)
    }
}
