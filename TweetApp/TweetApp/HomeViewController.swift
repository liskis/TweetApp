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
    var cellHeight: [CGFloat] = []
    
    override func viewDidLoad() {
        tweetView.dataSource = self
        tweetView.delegate = self
        tweetView.rowHeight = UITableView.automaticDimension
        tweetView.estimatedRowHeight = 10000
        tweetView.tableFooterView = UIView()
        tweetView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        setTweetData()
    }
    
    func setTweetData(){
        for i in 1...5 {
            var tweet = ""
            for _ in 0...i {
                tweet.append("このツイートは\(i)番目のツイートです。")
            }
            let tweetData = TweetDataModel(
                userName: "testUser(\(i))",
                tweet: tweet,
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
}

