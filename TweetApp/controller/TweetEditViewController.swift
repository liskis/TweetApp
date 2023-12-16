//
//  TweetEditViewController.swift
//  TweetApp
//
//  Created by 渡辺健輔 on 2023/12/08.
//
import UIKit
import RealmSwift

protocol TweetEditViewControllerDelegate {
    func recordUpdate()
}
class TweetEditViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var tweetView: UITextView!
    @IBOutlet weak var tweetBtn: UIButton!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var tweetViewPlaceholder: UILabel!
    @IBAction func chancelBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func tweetBtn(_ sender: UIButton) {
        if userNameField.text!.count > 0 && checkCharacterLimit(textCount: tweetView.text!.count) {
            saveData()
        }
    }
    var delegate: TweetEditViewControllerDelegate?
    var tweetData = TweetDataModel()
    let maxTweetCount: Int = 140
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetView.delegate = self
        configueUserNameField()
        configureTweetView()
        displayPlaceholder()
        configureTweetBtn()
        setDoneButton()
        userNameField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    func checkCharacterLimit(textCount: Int) -> Bool {
        return 1...maxTweetCount ~= textCount
    }
    func configueUserNameField(){
        userNameField.layer.borderColor = UIColor.darkGray.cgColor
        userNameField.layer.borderWidth = 1.0
        userNameField.layer.cornerRadius = 5.0
        userNameField.text = tweetData.userName
    }
    func configureTweetView(){
        tweetView.layer.borderColor = UIColor.darkGray.cgColor
        tweetView.layer.borderWidth = 1.0
        tweetView.layer.cornerRadius = 5.0
        tweetView.text = tweetData.tweet
    }
    // つぶやくボタンの背景色を変更
    func configureTweetBtn(){
        if userNameField.text!.count > 0 && checkCharacterLimit(textCount: tweetView.text!.count) {
            tweetBtn.tintColor = .systemBlue
        } else {
            tweetBtn.tintColor = .lightGray
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
    // placeholderの表示非表示
    func displayPlaceholder(){
        if tweetView.text.isEmpty {
            tweetViewPlaceholder.isHidden = false
        } else {
            tweetViewPlaceholder.isHidden = true
        }
    }
    
    func saveData(){
        let realm = try! Realm()
        try! realm.write{
            tweetData.userName = userNameField.text!
            tweetData.tweet = tweetView.text!
            tweetData.created = Date()
            realm.add(tweetData)
        }
        delegate?.recordUpdate()
        dismiss(animated: true)
    }
}
extension TweetEditViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        displayPlaceholder()
        // 文字数をカウントして表示
        tweetCountLabel.text = String(format: "%d/%d",textView.text.count, maxTweetCount)
        if textView.text.count > maxTweetCount {
            tweetCountLabel.textColor = .red
        } else {
            tweetCountLabel.textColor = .systemGray
        }
        configureTweetBtn()
    }
}
