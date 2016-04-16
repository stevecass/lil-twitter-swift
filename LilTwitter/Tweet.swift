//
//  Tweet.swift
//  LilTwitter
//
//  Created by Steven Cassidy on 4/16/16.
//  Copyright © 2016 Steven Cassidy. All rights reserved.
//

import Foundation
import SwiftyJSON

class Tweet {

  var id:Int
  var content: String
  var username: String
  var handle: String
  var avatarUrl: String
  var createdAt: NSDate
  var updatedAt: NSDate
  var hashtagNames: [String]

  init(json:[String:AnyObject]) {
    print(json)

    let dateFormatter = NSDateFormatter()
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"

    self.id = json["id"] as! Int
    self.content = json["content"] as! String
    self.username = json["username"] as! String
    self.handle  = json["handle"] as! String
    self.avatarUrl = json["avatar_url"] as! String
    self.createdAt = (dateFormatter.dateFromString(json["created_at"] as! String))!
    self.updatedAt = (dateFormatter.dateFromString(json["updated_at"] as! String))!
    self.hashtagNames = JSON(json["hashtag_names"]!).arrayValue.map({ $0.string! })
  }
}
