//
//  ViewController.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/5/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy

class ViewController: UIViewController, NSURLConnectionDelegate {
  
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var readBtn: UIButton!
  @IBOutlet weak var viewMyProductBtn: UIButton!
  @IBOutlet weak var btn: UIButton!
  var myRootRef: Firebase!
  var users : [User] = [User]()
  lazy var data = NSMutableData()
  var products : [Product] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    connectToThanhsServer()
    var url: String  = "http://54.86.116.203:3000/items/"
//    url = "http://search.twitter.com/search.json?q=blue%20angels"
    getDataFrom(url, url2: url)
    // Do any additional setup after loading the view, typically from a nib.
//    searchFunction()
    //startConnection()
    // setupFirebase()
  }
  
  func getDataFrom(url: String, url2: String){
    println("Made it here")
    println("Print JSON here")
    println("url \(url)")
    
    var request = HTTPTask()
    request.GET(url, parameters: nil, success: {(response: HTTPResponse) in
      if response.responseObject != nil {
        
        println("Hello from GrabData from Server")
        let data = response.responseObject as NSData
        let str = NSString(data: data, encoding: NSUTF8StringEncoding)
        let items = Items(JSONDecoder(response.responseObject!))
        for curr in items.items! {
          var user = User(email: "id")
          var product = Product(_id: curr._id!, __v: curr.__v!, price: curr.price!, created: curr.created!, title: curr.name!, description: curr.description!, category: "category", user: user)
          self.products.append(product)
          println(product.title)
          println("World from GrabData from Server")
        }
        
      }
      },failure: {(error: NSError) in
        println(" error \(error)")
    })
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func searchFunction() {
    var url : NSURL = NSURL(string: "https://itunes.apple.com/search?term=&media=software")!
    var request: NSURLRequest = NSURLRequest(URL:url)
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession(configuration: config)
    
    let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
      
      var newdata : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
      
      var info : NSArray =  newdata.valueForKey("results") as NSArray
      
      var name: String? = info.valueForKey("trackName") as? String // Returns nil
      println(name)//Returns nil
      
      
      var name2 : NSString = info.valueForKey("trackName") as NSString //Crashes
      println(name2) //Crashes
      
    });
    
    
    task.resume()
    println("Resumed")
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    if (segue.identifier == "segueTest") {
      println("grabed data and now passing \(products)")
      var svc = segue.destinationViewController as BuyTreeViewController
      svc.products =  products
      
    }
  }
  
  
  func startConnection(){
    
    var url : String = "http://54.86.116.203:3000/items"
    var request : NSMutableURLRequest = NSMutableURLRequest()
    request.URL = NSURL(string: url)
    request.HTTPMethod = "GET"
    println("34534")
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler:{(data, response, error) in
      var newdata : NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSArray
      
      var name: String? = newdata[0].valueForKey("name") as? NSString
//      println(name)
    });
    task.resume()
  }
  
  func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
    self.data.appendData(data)
  }
  func connectionDidFinishLoading(connection: NSURLConnection!) {
    var err: NSError
    // throwing an error on the line below (can't figure out where the error message is)
    var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
    println(jsonResult)
  }
  
  func connectToThanhsServer(){
    println("in 1")
    let url = NSURL(string: "")
    let theRequest = NSURLRequest(URL: url!)
    
    NSURLConnection.sendAsynchronousRequest(theRequest, queue: nil, completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
      if data.length > 0 && error == nil {
        let response : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options:nil, error: nil)
        println(response)
      }
    })
    
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

