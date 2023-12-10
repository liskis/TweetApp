//
//  UITweetView.swift
//  TweetApp
//
//  Created by 渡辺健輔 on 2023/12/10.
//

import UIKit

// 1. TextView を継承した HintTextView クラスを作る
@IBDesignable
class UITweetView: UITextView {
    
    // Placeholder として表示するテキスト
    var placeholderText = "" {
        didSet {
            placeholderLabel.text = placeholderText
        }
    }
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.textColor = .placeholderText
        return label
    }()
    
    // 追記: テキストの初期値を入れるときは textViewDidChange が発火しないのでこちらのメソッドを使用する
    // （もっと良い方法がありそうですが...）
    func setText(_ text: String) {
        self.text = text
        changeVisibility()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // 2. TextView の中に Label を置く
        addSubview(placeholderLabel)
        
    // Placeholder の表示位置を調整
        NSLayoutConstraint.activate([
        // hintLabe とその親である HintTextView のトップの余白
            placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        // hintLabe とその親である HintTextView で X 軸を一致させる
            placeholderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        // hintLabe はその親である HintTextView よりも幅を 10 小さくする（左右に 5 ずつ余白を設ける）
            placeholderLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -10),
        ])
        
        self.delegate = self
    }
    
    private func changeVisibility() {
        if self.text.isEmpty {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
    }
}

extension UITweetView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // 3. TextView に文字が入力されているかどうかで Label の表示/非表示を切り替える
        changeVisibility()
    }
}
