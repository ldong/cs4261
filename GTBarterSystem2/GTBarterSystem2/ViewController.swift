//
//  ViewController.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/5/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var btn: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func connectTofirebase(sender: AnyObject) {
    println("Called")
    var myRootRef = Firebase(url:"https://gtbarter.firebaseio.com/")
    myRootRef.setValue("Do you have data? You'll love Firebase.")
  }

}

