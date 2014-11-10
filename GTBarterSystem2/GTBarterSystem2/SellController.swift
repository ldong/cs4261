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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPicker.delegate = self
//        categoryPicker.dataSource = self
        
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
    self.navigationController?.pushViewController(mainView, animated: true)
  }
    @IBAction func postBtnClick(sender: AnyObject) {
      var test =  testPrice(priceText.text)
        println(test)
        println("about to execture post")
        var posted = post("http://54.86.116.203:3000/items", finished: (result: Bool) -> Void in {
            println("result is: \(result)")
            //do more stuff now that I know the result
            })
        
        if(posted && test){
            transition()
        }
    }
    
    func transition() {
        println("got into transition")
        let secondViewController:MyProductsTableViewController = MyProductsTableViewController()
        
        self.presentViewController(secondViewController, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    func post(url:String, {(finished:Bool) -> Bool in
      //  var url = "http://example"
        var request = HTTPTask()
        var parameters = ["description":descriptionText.text, "name": titleText.text, "price":priceText.text]
        request.requestSerializer = JSONRequestSerializer()
        request.POST(url, parameters: parameters,
            success: {
                (response: HTTPResponse) in
                if response.responseObject != nil {
                    finished(true)
                },
            }, failure: {(error: NSError) in
                println(" error \(error)")
                finished(false)
        })
    })
    
    
    
    
    
    func getDataFrom(url: String) -> Bool{
        var request = HTTPTask()
        var ret:Bool = true
        
        var paramaters = ["description":descriptionText.text, "name": titleText.text, "price":priceText.text]
        request.POST(url, parameters: paramaters, success: {(response: HTTPResponse) in
            if response.responseObject != nil {
               println("success")
                ret = true
                
            }
            },failure: {(error: NSError) in
                println(" error \(error)")
                ret = false
        })
        return ret
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
