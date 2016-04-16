//
//  ViewController.swift
//  LilTwitter
//
//  Created by Steven Cassidy on 4/16/16.
//  Copyright © 2016 Steven Cassidy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tfTweetText: UITextField!

  @IBAction func btnSendClicked(sender: AnyObject) {
    let tweet = tfTweetText.text
    print("I got clicked. Tweet text is \(tweet)")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

