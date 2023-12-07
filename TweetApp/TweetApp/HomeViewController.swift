//
//  HomeViewController.swift
//  TweetApp
//
//  Created by 渡辺健輔 on 2023/12/06.
//


import Foundation
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tweetView: UITableView!
    var tweetDataList: [TweetDataModel] = []
    
    override func viewDidLoad() {
        tweetView.dataSource = self
        tweetView.delegate = self
        tweetView.rowHeight = UITableView.automaticDimension
        tweetView.tableFooterView = UIView()
        tweetView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        setTweetData()
    }
    
    func setTweetData(){
        for i in 1...5 {
            let tweetData = TweetDataModel(
                userName: "testUser",
                tweet: "このツイートは\(i)番目のツイートです。このツイートは\(i)番目のツイートです。このツイートは\(i)番目のツイートです。",
                created: Date()
            )
            tweetDataList.append(tweetData)
        }
    }
}

extension HomeViewController: UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return 1
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath ) as! HomeTableViewCell
        cell.setCell(tweetData: tweetDataList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

