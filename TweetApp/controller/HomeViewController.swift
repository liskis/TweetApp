//
//  HomeViewController.swift
//  TweetApp
//
//  Created by 渡辺健輔 on 2023/12/06.
//
import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    @IBOutlet weak var tweetTableView: UITableView!
    @IBAction func addButton(_ sender: UIButton) {
        transitionToEditorView()
    }
    var tweetDataList: [TweetDataModel] = []
    var cellHeight: [CGFloat] = []
    override func viewDidLoad() {
        tweetTableView.dataSource = self
        tweetTableView.delegate = self
        tweetTableView.rowHeight = UITableView.automaticDimension
        tweetTableView.estimatedRowHeight = 10000
        tweetTableView.tableFooterView = UIView()
        tweetTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        setTweetData()
    }
    func transitionToEditorView(with tweetData: TweetDataModel? = nil) {
        let storyboard = UIStoryboard(name: "TweetEdit", bundle: nil)
        guard let tweetEditViewController = storyboard.instantiateInitialViewController() as? TweetEditViewController else { return }
        if let tweetData = tweetData {
            tweetEditViewController.tweetData = tweetData
        }
        present(tweetEditViewController, animated: true)
        tweetEditViewController.delegate = self
    }
    func setTweetData(){
        let realm = try! Realm()
        let results = realm.objects(TweetDataModel.self)
        tweetDataList = Array(results)
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
extension HomeViewController: UITableViewDelegate{
    //    セルを選択すると編集画面へ
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tweetData = tweetDataList[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        transitionToEditorView(with: tweetData)
    }
    //    セルをスライドして削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id = tweetDataList[indexPath.row].id
        let realm = try! Realm()
        let tweetDataList = Array(realm.objects(TweetDataModel.self).filter("id = %@", id))
        tweetDataList.forEach({ tweetData in
            try! realm.write {
                realm.delete(tweetData)
            }
        })
        setTweetData()
        tweetTableView.reloadData()
    }
}
extension HomeViewController: TweetEditViewControllerDelegate {
    func recordUpdate() {
        setTweetData()
        tweetTableView.reloadData()
    }
}

