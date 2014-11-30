//
//  LoginPageViewController.swift
//  GTBarterSystem2
//
//  Created by Haytham Abutair on 10/30/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import UIKit
import JSONJoy
import SwiftHTTP

class LoginPageViewController: UIViewController {
    
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var tfUserId: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    var __v:AnyObject?
    var _id:AnyObject!
    var created:AnyObject?
    var displayName:AnyObject?
    var email:AnyObject?
    var firstName:AnyObject?
    var lastName:AnyObject?
    var provider:AnyObject?
    var category:AnyObject?
    
    var proceed: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("inininin")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func connectToServerAndGetCookie(username: String, password: String, finished:((String) -> Void)) -> Void {
        var url = "http://54.86.116.203:3000/auth/signin"
        var request = HTTPTask()
        var parameters = ["username": username, "password": password]
        request.requestSerializer = JSONRequestSerializer()
        request.POST(url, parameters: parameters, success: {
            (response: HTTPResponse) in
            if response.responseObject != nil {
                //finished(true)
                self.proceed = true
                println("Hello from getting cookies from Server")
                var error: NSError?
                let jsonData: NSData = response.responseObject as NSData
                
                let jsonDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as NSDictionary
                
                
                //we can just grab the the ID or whatever we need to be passed to next screen.
//                self.__v = jsonDict["__v"];
                self._id = jsonDict["_id"];
                finished(self._id as String)
                self.category = jsonDict["category"]
                
//                self.created = jsonDict["created"];
//                self.displayName = jsonDict["displayName"];
//                self.email = jsonDict["email"];
//                self.firstName = jsonDict["firstName"];
//                self.lastName = jsonDict["lastName"];
                
                println("id \(self._id)")
//                println("v: \(self.__v) id: \(self._id) created: \(self.created) displayname \(self.displayName) email \(self.email) firstname \(self.firstName) lastname \(self.lastName)")
//                
            }
            },failure: {(error: NSError) in
                finished(" ")
                println(" error \(error)")
        })
    }
    
    
    @IBAction func signInBtnClick(sender: AnyObject) {
        if(tfUserId.text ==  "" || tfPassword.text == ""){
            println("failed login user id : \(tfUserId.text)  and password \(tfPassword.text))")
        }
        else{
            var result: Bool = false
            connectToServerAndGetCookie(tfUserId.text, password: tfPassword.text, finished: { (result:String) -> Void in
                if result != " " {
                    dispatch_async(dispatch_get_main_queue()) {
                        // self.performSegueWithIdentifier("toView2", sender: self)
                        self.performSegueWithIdentifier("loginToViewController", sender: self)
                    }
                } else {
                    println("You are not signed in")
                }
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        println("got into segue fo buy")
        if (segue.identifier == "loginToViewController" && self.proceed == true) {
            println("segue buy")
            var svc = segue.destinationViewController as ViewController
            svc.__v = self.__v
            svc._id = self._id
            println("id \(self._id)")
            svc.created = self.created
            svc.displayName = self.displayName
            svc.firstName = self.firstName
            svc.lastName = self.lastName
            svc.category = self.category
        } else {
            println("PrepareForSegue run, else statement")
        }
        
    }
    
    
    
    
}