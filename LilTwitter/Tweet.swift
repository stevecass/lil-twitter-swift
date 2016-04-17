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

  var id:Int?
  var content: String?
  var username: String?
  var handle: String?
  var avatarUrl: String?
  var createdAt = NSDate()
  var updatedAt = NSDate()
  var hashtagNames: [String] = []


  init(json:[String:AnyObject]) {
    print(json)

    let dateFormatter = NSDateFormatter()
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"

    self.id = json["id"] as? Int
    self.content = json["content"] as? String
    self.username = json["username"] as? String
    self.handle  = json["handle"] as? String
    self.avatarUrl = json["avatar_url"] as? String
    self.createdAt = (dateFormatter.dateFromString(json["created_at"] as! String))!
    self.updatedAt = (dateFormatter.dateFromString(json["updated_at"] as! String))!
    self.hashtagNames = JSON(json["hashtag_names"]!).arrayValue.map({ $0.string! })
  }

  init(content: String) {
    self.content = content
    self.hashtagNames = parseoutHashtags()
    self.content = contentWithoutHashtags()
  }

  func age() -> String {
    return updatedAt.getElapsedInterval()
  }

  func contentForDisplay() -> String {
    let tags = hashtagNames.reduce("", combine: { (acc, s) -> String in
      return "\(acc) #\(s)"
    })
    return "\(content!) \(tags)"
  }

  private func contentWithoutHashtags() -> String {
     let regex = try! NSRegularExpression(pattern: "(^|\\s)(#[a-z][a-z\\d-]+)", options: .CaseInsensitive)
     return regex.stringByReplacingMatchesInString(content!, options: .WithTransparentBounds, range: NSMakeRange(0, content!.characters.count), withTemplate: "")


  }

  private func parseoutHashtags() -> [String] {
    let matches = matchesForRegexInText("(^|\\s)(#[a-z][a-z\\d-]+)", text:content)
    return matches.map({ (s) -> String in
      let trimmed = s.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
      return trimmed.substringFromIndex(trimmed.startIndex.advancedBy(1))
    })

  }
}
