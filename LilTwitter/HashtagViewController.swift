//
//  HashtagViewController.swift
//  LilTwitter
//
//  Created by Steven Cassidy on 4/17/16.
//  Copyright © 2016 Steven Cassidy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class HashtagViewController : UITableViewController {

  var tags: [String] = []


  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tags.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("htCell", forIndexPath: indexPath)
    cell.textLabel?.text = tags[indexPath.row]
    return cell
  }


  override func viewDidLoad() {
    super.viewDidLoad()
    print("Loaded \(NSStringFromClass(self.dynamicType))")
    loadHashtags()
  }

  private func loadHashtags() {
    Alamofire.request(.GET, "http://localhost:3000/hashtags/popular").responseJSON { (responseData) -> Void in
      if((responseData.result.value) != nil) {
        let json = JSON(responseData.result.value!)
        if let data = json.arrayObject {
          self.tags = data.map { JSON($0)["name"].string! }
          dispatch_async(dispatch_get_main_queue(), {self.tableView.reloadData() })
        }
      }
    }
  }

}
