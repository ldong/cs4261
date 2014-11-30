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
 
//    @IBOutlet weak var viewMyProductsBtn: UIButton!
  @IBOutlet weak var btn: UIButton!
  var myRootRef: Firebase!
  var users : [User] = [User]()
  lazy var data = NSMutableData()
  var products : [Product] = []
    
    @IBOutlet var testID: UILabel!
    
    var __v:AnyObject?
    var _id: AnyObject!
    var created:AnyObject?
    var displayName:AnyObject?
    var email:AnyObject?
    var firstName:AnyObject?
    var lastName:AnyObject?
    var provider:AnyObject?
    var category: AnyObject?
    
    var trash:String = ""
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
//     println("~~~~~~~~~~~~~~~~~~~~~~~~~viewcontroller v: \(self.__v) id: \(self._id) created: \(self.created) displayname \(self.displayName) email \(self.email) firstname \(self.firstName) lastname \(self.lastName)")
//    println("~~~~~~~~ \(self.trash)")
    println("main controller id \(self._id)")
    testID.text = self._id as String!
    getDataFrom("http://54.86.116.203:3000/items", ret: { (result:Bool) -> (Void) in
        println("buy button is:  \(result) ")
        dispatch_async(dispatch_get_main_queue()) {
            
        }
        
    })

    //startConnection();
    
  }
    
    
    func getDataFrom(url: String, ret: (Bool) -> (Void)) -> Void{
        var request = HTTPTask()
        request.GET(url, parameters: nil, success: {(response: HTTPResponse) in
            if response.responseObject != nil {
                
                let data = response.responseObject as NSData
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                let items = Items(JSONDecoder(response.responseObject!))
                for curr in items.items! {
                    var user = User(email: "id", _id: "my id")
//                    println("_id: \(curr._id), __v: \(curr.__v), price: \(curr.price), created: \(curr.created), title: \(curr.name), description: \(curr.description), category: category, user: \(user)")
                    if(curr.price != nil){
                        println("name is \(curr) ")
                       // println("description is \(curr.description!) ")
                        var product = Product(_id: curr._id!, __v: curr.__v!,price: curr.price!, created: curr.created!, title: curr.name!, description: curr.description!, category: curr.category!, user: user)
                        self.products.append(product)
                    }
                    
                    //   println(product.title)
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
  
   
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    println("PrepareForSegue run")

    if (segue.identifier == "segueTest") {
      println("grabed data and now passing \(products)")
      println("PrepareForSegue run, if statement")
      var svc = segue.destinationViewController as BuyTreeViewController
      svc.products =  products
    }
    
    if (segue.identifier == "myProductsSegue") {
        println("my products :)")
        var svc = segue.destinationViewController as MyProductsTableViewController
            svc.userId = self._id
        println(products)
        svc.userProducts = products
    }
    else {
      println("PrepareForSegue run, else statement")
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

