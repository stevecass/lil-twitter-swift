//
//  DateIntervalExtension.swift
//  LilTwitter
//
//  Created by Steven Cassidy on 4/16/16.
//  Copyright © 2016 Steven Cassidy. All rights reserved.
//

import Foundation
// Nabbed from http://stackoverflow.com/questions/34457434/swift-convert-time-to-time-ago

extension NSDate {

  func getElapsedInterval() -> String {

    var interval = NSCalendar.currentCalendar().components(.Year, fromDate: self, toDate: NSDate(), options: []).year

    if interval > 0 {
      return interval == 1 ? "\(interval)" + " " + "year" :
        "\(interval)" + " " + "years"
    }

    interval = NSCalendar.currentCalendar().components(.Month, fromDate: self, toDate: NSDate(), options: []).month
    if interval > 0 {
      return interval == 1 ? "\(interval)" + " " + "month" :
        "\(interval)" + " " + "months"
    }

    interval = NSCalendar.currentCalendar().components(.Day, fromDate: self, toDate: NSDate(), options: []).day
    if interval > 0 {
      return interval == 1 ? "\(interval)" + " " + "day" :
        "\(interval)" + " " + "days"
    }

    interval = NSCalendar.currentCalendar().components(.Hour, fromDate: self, toDate: NSDate(), options: []).hour
    if interval > 0 {
      return interval == 1 ? "\(interval)" + " " + "hour" :
        "\(interval)" + " " + "hours"
    }

    interval = NSCalendar.currentCalendar().components(.Minute, fromDate: self, toDate: NSDate(), options: []).minute
    if interval > 0 {
      return interval == 1 ? "\(interval)" + " " + "minute" :
        "\(interval)" + " " + "minutes"
    }

    return "a moment"
  }
}