//
//  SellController.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/5/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy

class SellController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var categoryPicker: UIPickerView!
    var elements:Array<String>?
    var user:String = ""
    var cookie: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPicker.delegate = self
//        categoryPicker.dataSource = self
            println("in sell controller, user  \(user)")
            elements = ["Electronics","Fashion","Entertainment","Sporting Goods","Motors","Home and Kitchen","Other"]
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int
    {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int
    {
        return elements!.count;
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String
    {
        return elements![row]
    }
    
    
  
  @IBAction func SellSwipe(sender: AnyObject) {
    println("Swiped from sell to main")
    let mainView = self.storyboard?.instantiateViewControllerWithIdentifier("mainController") as ViewController
    mainView._id = user
    self.navigationController?.pushViewController(mainView, animated: true)
  }
    @IBAction func postBtnClick(sender: AnyObject) {
      var testPriceValid =  testPrice(priceText.text)
        getDataFrom("http://54.86.116.203:3000/items", ret: { (result:Bool) -> (Void) in
                println("sell button is:  \(result) ")
            if(result && testPriceValid){
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("goBackToMainFromSell", sender: self)
            }
            }
        })
      
        
     //   var postedData = getDataFrom("http://54.86.116.203:3000/items", ret:(result:Bool) -> Void in {
      //      println(ret)
      //      })
     //   if(postedData && test){
     //       transition()
      //  }
    }
    
    func transition() {
        println("got into transition")
        let secondViewController:MyProductsTableViewController = MyProductsTableViewController()
        
        self.presentViewController(secondViewController, animated: true, completion: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goBackToMainFromSell") {
            println("my products :)")
            var svc = segue.destinationViewController as ViewController
            println("goinggggg back")
            svc._id = self.user
        }

    }
    
    
    
    
    func getDataFrom(url: String, ret: (Bool) -> (Void)) -> Void{
        var request = HTTPTask()
        println("\(descriptionText.text) \(titleText.text) \(priceText.text)")
        var paramaters = ["description":descriptionText.text, "name": titleText.text, "price":priceText.text]
        request.POST(url, parameters: paramaters, success: {(response: HTTPResponse) in
            if response.responseObject != nil {
               println("success")
                ret(true)
                
            }
            },failure: {(error: NSError) in
                println(" error \(error)")
                ret(false)
        })
        //return ret
    }

    
    
    func testPrice(priceText:String) -> Bool {
        let price:Int? = priceText.toInt()
        println(price)
        if(price != nil){
        return true
        }
        let alert = UIAlertView()
        alert.title = "Invalid Price"
        alert.message = "Please insert a whole dollar amount"
        alert.addButtonWithTitle("Got It!")
        alert.show()
        return false
        
    }

}
