//
//  TweetDataModel.swift
//  TweetApp
//
//  Created by 渡辺健輔 on 2023/12/06.
//

import Foundation
import RealmSwift

class TweetDataModel: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var userName: String = ""
    @objc dynamic var tweet: String = ""
    @objc dynamic var created: Date = Date()
}
