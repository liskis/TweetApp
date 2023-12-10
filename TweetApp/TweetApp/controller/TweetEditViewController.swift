//
//  TweetEditViewController.swift
//  TweetApp
//
//  Created by 渡辺健輔 on 2023/12/08.
//

import UIKit

class TweetEditViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var tweetView: UITweetView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configueUserNameField()
        configureTweetView()
        tweetView.placeholderText = "今何してる？"
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
//        tweetView.layer.masksToBounds = true
    }
}
