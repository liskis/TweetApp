//
//  TweetEditViewController.swift
//  TweetApp
//
//  Created by 渡辺健輔 on 2023/12/08.
//

import UIKit
import RealmSwift

class TweetEditViewController: UIViewController {
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var tweetView: UITextView!
    @IBOutlet weak var tweetBtn: UIButton!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var tweetViewPlaceholder: UILabel!
    
    
    @IBAction func tweetBtn(_ sender: UIButton) {
        if (userNameField.text! != "" ) && (tweetView.text! != "") {
            saveData()
        }
    }
    
    let tweetData = TweetDataModel()
    let maxTweetCount: Int = 140
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetView.delegate = self
        configueUserNameView()
        configureTweetView()
        configureTweetBtn()
        setDoneButton()
        userNameField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func configueUserNameView(){
        userNameField.layer.borderColor = UIColor.darkGray.cgColor
        userNameField.layer.borderWidth = 1.0
        userNameField.layer.cornerRadius = 5.0
    }
    
    func configureTweetView(){
        tweetView.layer.borderColor = UIColor.darkGray.cgColor
        tweetView.layer.borderWidth = 1.0
        tweetView.layer.cornerRadius = 5.0
    }
    
    // つぶやくボタンの背景を変更
    func configureTweetBtn(){
        if userNameField.text == ""  || tweetView.text == "" {
            tweetBtn.tintColor = .lightGray
        } else {
            tweetBtn.tintColor = .systemBlue
        }
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
    
    @objc func textFieldDidChange(sender: UITextField) {
        configureTweetBtn()
    }
    
    func saveData(){
        let realm = try! Realm()
        try! realm.write{
            tweetData.userName = userNameField.text!
            tweetData.tweet = tweetView.text!
            tweetData.created = Date()
            realm.add(tweetData)
        }
        print(tweetData)
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
            tweetCountLabel.text = String(format: "%d/%d",textView.text.count, maxTweetCount)
            if textView.text.count > maxTweetCount {
                tweetCountLabel.textColor = .red
            } else {
                tweetCountLabel.textColor = .systemGray
            }
            configureTweetBtn()
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var check: Bool = true
        let textCount = textView.text.count - range.length + text.count
        check = textCount <= maxTweetCount
        return check
    }

}
