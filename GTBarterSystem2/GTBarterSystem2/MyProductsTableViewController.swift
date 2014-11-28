//
//  MyProductsTableViewController.swift
//  GTBarterSystem2
//
//  Created by Haytham Abutair on 11/9/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy

class MyProductsTableViewController: UITableViewController {
    
    var userId:AnyObject?
    var userProducts: [Product] = []
    var cookie:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("user id \(self.userId)")
        println(userProducts)
        // Uncomment the following line to preserve selection between presentations
        //    self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProducts.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as CustomTableViewCell
        
        var product : Product
        // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
        product = userProducts[indexPath.row]
        // Configure the cell
        //cell.textLabel!.text = product.title
        
        println(product.title)
        //    println(cell)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.productTitle.text = product.title
        cell.productId.text = product._id
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            println("edittttinnggg")
            var cell: CustomTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as CustomTableViewCell
            self.userProducts.removeAtIndex(indexPath.row)
            self.deleteItemFromServer("http://54.86.116.203:3000/items/", itemID: cell.productId.text!, ret: { (result:Bool) -> (Void) in
                println("buy button is:  \(result) ")
                dispatch_async(dispatch_get_main_queue()) {
                    
                    
                }
            })
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    func deleteItemFromServer(url: String, itemID:String, ret: (Bool) -> (Void)) -> Void{
        var request = HTTPTask()
        var finalUrl = url + itemID
        println(finalUrl)
        request.DELETE(finalUrl, parameters: nil, success: {(response: HTTPResponse) in
            if response.responseObject != nil {
                let data = response.responseObject as NSData
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                let items = Items(JSONDecoder(response.responseObject!))
                
            }
            },failure: {(error: NSError) in
                println(" error \(error)")
        })
    }
    
    
}
