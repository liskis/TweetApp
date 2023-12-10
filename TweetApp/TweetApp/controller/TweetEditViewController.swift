//
//  TweetEditViewController.swift
//  TweetApp
//
//  Created by 渡辺健輔 on 2023/12/08.
//

import UIKit

class TweetEditViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var tweetView: UITextView!
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var tweetViewPlaceholder: UILabel!
    
    let maxCharacterCount: Int = 140
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetView.delegate = self
        configueUserNameField()
        configureTweetView()
        setDoneButton()
    }
    
    func configueUserNameField(){
        userNameField.layer.borderColor = UIColor.darkGray.cgColor
        userNameField.layer.borderWidth = 1.0
        userNameField.layer.cornerRadius = 5.0
    }
    
    func configureTweetView(){
        tweetView.layer.borderColor = UIColor.darkGray.cgColor
        tweetView.layer.borderWidth = 1.0
        tweetView.layer.cornerRadius = 5.0
    }
    
    @objc func tapDoneButton() {
        view.endEditing(true)
    }
    
    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        tweetView.inputAccessoryView = toolBar
        userNameField.inputAccessoryView = toolBar
    }
}

extension TweetEditViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // placeholderの表示非表示
        if textView.text.isEmpty {
            tweetViewPlaceholder.isHidden = false
        } else {
            tweetViewPlaceholder.isHidden = true
        }
        
        // 文字数をカウントして表示
        characterCountLabel.text = String(format: "%d/%d",textView.text.count, maxCharacterCount)
        if textView.text.count > maxCharacterCount {
            characterCountLabel.textColor = .red
        } else {
            characterCountLabel.textColor = .systemGray
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 文字数が140を超えると入力できなくなる
        let newCharacterCount = textView.text.count - range.length + text.count
        return (newCharacterCount <= maxCharacterCount)
    }

}
