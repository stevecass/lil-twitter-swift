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
  var refreshControl: UIRefreshControl!

  @IBAction func btnSendClicked(sender: AnyObject) {
    if tfTweetText.text!.characters.count < 1 {
      let alert = UIAlertController(title: "Blank tweet?", message:"Enter some text first", preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
      self.presentViewController(alert, animated: true){}
    } else {
      let enteredTweet = Tweet(content: tfTweetText.text!)
      createTweet(enteredTweet)
    }
  }

  // UITableViewDataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    let tweet = tweets[indexPath.row]
    cell.textLabel?.text = tweet.contentForDisplay()
    cell.detailTextLabel?.text = "\(tweet.handle!) \(tweet.age()) ago"
    return cell
  }

  func refreshTable(sender:AnyObject) {
    loadTweetList()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(ViewController.refreshTable), forControlEvents: UIControlEvents.ValueChanged)
    self.tableView.addSubview(self.refreshControl)
    tableView.estimatedRowHeight = 68.0
    tableView.rowHeight = UITableViewAutomaticDimension
    loadTweetList()
  }

  func createTweet(tw: Tweet) {
    let params: [String: AnyObject] = ["hashtags" : tw.hashtagNames, "tweet": ["content": tw.content!]]
    let headers: [String : String] = [:]
    Alamofire.request(.POST, API_TWEETS, parameters: params, encoding: .JSON, headers: headers).responseJSON { (responseData) -> Void in
      let tweet = Tweet(json: JSON(responseData.result.value!).dictionaryObject!)
      self.tweets.insert(tweet, atIndex: 0)
      dispatch_async(dispatch_get_main_queue(), {self.tableView.reloadData() })
      dispatch_async(dispatch_get_main_queue(), {self.tfTweetText.text = "" })

    }
  }

  private func loadTweetsFromUrl(url: String) {
    Alamofire.request(.GET, url).responseJSON { (responseData) -> Void in
      if((responseData.result.value) != nil) {
        let swiftyJsonVar = JSON(responseData.result.value!)
        if let data = swiftyJsonVar.arrayObject {
          self.tweets = data.map({ (item) -> Tweet in
            return Tweet(json: (JSON(item).dictionaryObject)!)
          })
          dispatch_async(dispatch_get_main_queue(), { self.tableView.reloadData() })
          dispatch_async(dispatch_get_main_queue(), { self.refreshControl.endRefreshing() })
          dispatch_async(dispatch_get_main_queue(), { self.tabBarController!.selectedIndex = 0 })
        }
      }
    }
  }

  func loadTweetsWithTag(tag: String) {
    let url = "\(API_SEARCH)/\(tag)"
    loadTweetsFromUrl(url)
  }


  func loadTweetList() {
    loadTweetsFromUrl(API_RECENT)
  }


  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

