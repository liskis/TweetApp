//
//  TweetEditViewController.swift
//  TweetApp
//
//  Created by 渡辺健輔 on 2023/12/08.
//

import UIKit
import SwiftUI

class TweetEditViewController: UIViewController {
    @State var text: String = ""
    var body: some View {
        TextField("テキストフィールド", text: $text, axis: .vertical)
            .font(.system(size: 25))
            .textFieldStyle(.roundedBorder)
            .padding(.all)
    }
    @IBOutlet weak var tweetField: UITextField!
    
}
