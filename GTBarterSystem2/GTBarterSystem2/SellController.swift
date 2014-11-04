//
//  SellController.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/5/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import UIKit

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
