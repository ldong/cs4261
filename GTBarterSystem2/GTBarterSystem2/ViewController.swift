//
//  ViewController.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/5/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var readBtn: UIButton!
  @IBOutlet weak var viewMyProductBtn: UIButton!
  @IBOutlet weak var btn: UIButton!
  var myRootRef: Firebase!
  var users : [User] = [User]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    setupFirebase()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  

  @IBAction func connectTofirebase(sender: AnyObject) {
    println("Write Called")
    
  }
  
  @IBAction func readFromFirebase(sender: AnyObject) {
    println("Read Called")
  }
  
  @IBAction func displayProducts(sender: AnyObject) {
    println("displayProduct got called")
    var username = usernameTextField.text
    println(username)
    var ref = Firebase(url:"https://gtbarter.firebaseio.com/products")
    ref.observeEventType(.Value, withBlock: {
      snapshot in
      println("\(snapshot.name) -> \(snapshot.value)")
    })
  }
  
  func setupFirebase() {
    // *** STEP 1: SETUP FIREBASE
//    myRootRef = Firebase(url:"https://gtbarter.firebaseio.com/")
    // *** STEP 2: RECEIVE MESSAGES FROM FIREBASE
//    myRootRef.observeEventType(.Value, withBlock: {
//      snapshot in
//      println("\(snapshot.name) -> \(snapshot.value)")
//    })
  }
  
  func loadUsers(input: String) -> [User] {
    return users
  }

}

