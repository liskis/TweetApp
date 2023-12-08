//
//  HomeTableViewCell.swift
//  TweetApp
//
//  Created by 渡辺健輔 on 2023/12/06.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweet: UITextView!
    @IBOutlet weak var created: UILabel!
    
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .long
        df.timeZone = TimeZone(identifier: "Asia/Tokyo")
        df.locale = Locale(identifier: "ja-JP")
        df.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        return df
    }
   
    func setCell(tweetData: TweetDataModel){
        self.userName.text = tweetData.userName
        self.tweet.text = tweetData.tweet
        self.created.text = self.dateFormatter.string(from: tweetData.created)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

