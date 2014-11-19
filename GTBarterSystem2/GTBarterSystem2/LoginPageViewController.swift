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
    var _id:AnyObject?
    var created:AnyObject?
    var displayName:AnyObject?
    var email:AnyObject?
    var firstName:AnyObject?
    var lastName:AnyObject?
    var provider:AnyObject?
    var cookie: String?
    
    
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
    
    func connectToServerAndGetCookie(username: String, password: String, finished:((NSDictionary?) -> Void)) -> Void {
        var url = "http://54.86.116.203:3000/auth/signin"
        var request = HTTPTask()
        var parameters = ["username": username, "password": password]
        request.requestSerializer = JSONRequestSerializer()
        request.POST(url, parameters: parameters, success: {
            (response: HTTPResponse) in
            if response.responseObject != nil {
                //finished(true)
              //  self.proceed = true
                var cookieHeader = response.headers!["Set-Cookie"]
              //  var cookieSets1 = cookieHeader!.componentsSeparatedByString(";")
              //  var cookieSets2 = cookieSets1[0].componentsSeparatedByString("=")
               // self.cookie = cookieSets2[1]
               // println("cookie is \(self.cookie!)")
                println("Hello from getting cookies from Server")
                var error: NSError?
                let jsonData: NSData = response.responseObject as NSData
                
                let jsonDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as NSDictionary
                
                finished(jsonDict)
                
                //we can just grab the the ID or whatever we need to be passed to next screen.
                
                /*
                println("v: \(self.__v) id: \(self._id) created: \(self.created) displayname \(self.displayName) email \(self.email) firstname \(self.firstName) lastname \(self.lastName)")
                */
            }
            },failure: {(error: NSError) in
                finished(nil)
                println(" error \(error)")
        })
    }
    
    
    @IBAction func signInBtnClick(sender: AnyObject) {
            var result: NSDictionary?
            connectToServerAndGetCookie(tfUserId.text, password: tfPassword.text, finished: { (jsonDict:NSDictionary?) -> Void in
                println("result is: \(jsonDict)")
                if (jsonDict? != nil) {
                    println("You signed in")
                    self.__v = jsonDict!["__v"];
                    self._id = jsonDict!["_id"];
                    self.created = jsonDict!["created"];
                    self.displayName = jsonDict!["displayName"];
                    self.email = jsonDict!["email"];
                    self.firstName = jsonDict!["firstName"];
                    self.lastName = jsonDict!["lastName"];
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("loginToViewController", sender: self)
                    }
                } else {
                    println("You are not signed in")
                }
            })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        println("got into segue fo buy")
        if (segue.identifier == "loginToViewController") {
            println("segue buy")
            var svc = segue.destinationViewController as ViewController
            svc.__v = self.__v
            svc._id = self._id
            svc.created = self.created
            svc.displayName = self.displayName
            svc.firstName = self.firstName
            svc.lastName = self.lastName
            svc.cookie = self.cookie
        } else {
            println("PrepareForSegue run, else statement")
        }
        
    }
    
    
    
    
}