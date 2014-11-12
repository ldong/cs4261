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
 
  @IBOutlet weak var userID: UILabel!
  @IBOutlet weak var btn: UIButton!
  var myRootRef: Firebase!
  var users : [User] = [User]()
  lazy var data = NSMutableData()
  var products : [Product] = []
    
    var __v:AnyObject?
    var _id: AnyObject?
    var created:AnyObject?
    var displayName:AnyObject?
    var email:AnyObject?
    var firstName:AnyObject?
    var lastName:AnyObject?
    var provider:AnyObject?
    var cookie:String?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
     self.userID.text = self._id as String!
        getDataFrom("http://54.86.116.203:3000/items", ret: { (result:Bool) -> (Void) in
        println("buy button is:  \(result) ")
        dispatch_async(dispatch_get_main_queue()) {
        }
    })
  }
    
    
    func getDataFrom(url: String, ret: (Bool) -> (Void)) -> Void{
        var request = HTTPTask()
        request.GET(url, parameters: nil, success: {(response: HTTPResponse) in
            if response.responseObject != nil {
                
                let data = response.responseObject as NSData
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                let items = Items(JSONDecoder(response.responseObject!))
                for curr in items.items! {
                    
                    var user = User(email: "id",id: curr.user!._id!)
                    println("_id: \(curr._id), __v: \(curr.__v), price: \(curr.price), created: \(curr.created), title: \(curr.name), description: \(curr.description), category: category, user: \(user)")
                                           var product = Product(_id: curr._id, __v: curr.__v, price: curr.price, created: curr.created, title: curr.name, description: curr.description, category: "category", user: curr.user!._id!)
                        self.products.append(product)
                    
                    
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
        svc.cookie = self.cookie
            svc.userProducts = filterProductsForUser()
    }
    if (segue.identifier == "GoFromMainToSell") {
        println("my sell products :)")
        var svc = segue.destinationViewController as SellController
        svc.user = (self._id as String!)
        svc.cookie = self.cookie
       
    }

        
    else {
      println("PrepareForSegue run, else statement")
    }
    
  }
    
    func filterProductsForUser() -> [Product] {
        var filteredProducts: [Product] = []
      //  println("prrrrooodd \(self._id as String!)")
        for product in products {
            println("product is \(product.user) and curr id \(self._id as String!)")
            if(product.user == self._id as String!){
                filteredProducts.append(product)
            }
        }
        println("from control \(filteredProducts)")
        return filteredProducts
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
  
  func loadUsers(input: String) -> [User] {
    return users
  }
  
}

