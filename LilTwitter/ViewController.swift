//
//  ViewController.swift
//  LilTwitter
//
//  Created by Steven Cassidy on 4/16/16.
//  Copyright © 2016 Steven Cassidy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  var tweets:[Tweet] = []

  @IBOutlet weak var tfTweetText: UITextField!
  @IBOutlet weak var tableView: UITableView!

  @IBAction func btnSendClicked(sender: AnyObject) {
    let tweet = tfTweetText.text
    print("I got clicked. Tweet text is \(tweet)")
  }

  // UITableViewDataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    let tweet = tweets[indexPath.row]
    cell.textLabel?.text = tweet.content
    cell.detailTextLabel?.text = tweet.handle
    return cell
  }

  func reloadTable() {
    dispatch_async(dispatch_get_main_queue(), {
      self.tableView.reloadData()
    })
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    loadTweetList()
  }

  func loadTweetList() {
    Alamofire.request(.GET, "http://localhost:3000/tweets/recent").responseJSON { (responseData) -> Void in
      if((responseData.result.value) != nil) {
        let swiftyJsonVar = JSON(responseData.result.value!)
        if let data = swiftyJsonVar.arrayObject {
          self.tweets = data.map({ (item) -> Tweet in
            return Tweet(json: (JSON(item).dictionaryObject)!)
          })
          self.reloadTable()
        }
      }
    }
  }


  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

