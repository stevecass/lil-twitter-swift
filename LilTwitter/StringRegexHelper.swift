//
//  StringRegexHelper.swift
//  LilTwitter
//
//  Created by Steven Cassidy on 4/17/16.
//  Copyright © 2016 Steven Cassidy. All rights reserved.
//

import Foundation

func matchesForRegexInText(regex: String!, text: String!) -> [String] {

  do {
    let regex = try NSRegularExpression(pattern: regex, options: .CaseInsensitive)
    let nsString = text as NSString
    let results = regex.matchesInString(text, options: [], range: NSMakeRange(0, nsString.length))
    return results.map { nsString.substringWithRange($0.range)}
  } catch let error as NSError {
    print("invalid regex: \(error.localizedDescription)")
    return []
  }
}
