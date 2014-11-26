//
//  BuyTreeViewController.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/5/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy

class BuyTreeViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
  
  
  var products : [Product] = []
  var filteredProducts = [Product]()
  
   override func viewDidLoad() {
    super.viewDidLoad()
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
        self.tableView.reloadData()
    })
    }
    
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    
      

    
    
    
//    func getDataFrom(url: String){
//        var request = HTTPTask()
//        request.GET(url, parameters: nil, success: {(response: HTTPResponse) in
//            if response.responseObject != nil {
//                
//                let data = response.responseObject as NSData
//                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
//                let items = Items(JSONDecoder(response.responseObject!))
//                for curr in items.items! {
//                    var user = User(email: "id")
//                    var product = Product(_id: curr._id!, __v: curr.__v!, price: curr.price!, created: curr.created!, title: curr.name!, description: curr.description!, category: "category", user: user)
//                    self.products.append(product)
//                    println(product.title)
//                }
//                
//            }
//            },failure: {(error: NSError) in
//                println(" error \(error)")
//        })
//    }

    
  
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == self.searchDisplayController!.searchResultsTableView {
      return self.filteredProducts.count
    } else {
      return self.products.count
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
    let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
    
    var product : Product
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    if tableView == self.searchDisplayController!.searchResultsTableView {
      product = filteredProducts[indexPath.row]
    } else {
      product = products[indexPath.row]
    }
    
    // Configure the cell
    cell.textLabel.text = product.title
    println(product.title)
//    println(cell)
    cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    
    return cell
  }
  
  func filterContentForSearchText(searchText: String, scope: String = "All") {
    self.filteredProducts = self.products.filter(
      {
        ( product : Product) -> Bool in
        var categoryMatch = (scope == "All") || (product.category == scope)
        var stringMatch = product.title.rangeOfString(searchText)
        return categoryMatch && (stringMatch != nil)
    })
  }
  
  func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
    let scopes = self.searchDisplayController!.searchBar.scopeButtonTitles as [String]
    let selectedScope = scopes[self.searchDisplayController!.searchBar.selectedScopeButtonIndex] as String
    self.filterContentForSearchText(searchString, scope: selectedScope)
    return true
  }
  
  func searchDisplayController(controller: UISearchDisplayController!,
    shouldReloadTableForSearchScope searchOption: Int) -> Bool {
      let scope = self.searchDisplayController!.searchBar.scopeButtonTitles as [String]
      self.filterContentForSearchText(self.searchDisplayController!.searchBar.text, scope: scope[searchOption])
      return true
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.performSegueWithIdentifier("productDetail", sender: tableView)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    if segue.identifier == "productDetail" {
//      let productDetailViewController = segue.destinationViewController as UIViewController
      let productDetailViewController = segue.destinationViewController as ProductDetailViewController
      
      
      if sender as UITableView == self.searchDisplayController!.searchResultsTableView {
        let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()!
        let destinationTitle = self.filteredProducts[indexPath.row].title
        productDetailViewController.title = destinationTitle
        productDetailViewController.productPriceText = String(self.products[indexPath.row].title)
        productDetailViewController.productTitleText = self.products[indexPath.row].title
        productDetailViewController.productDescriptionText = self.products[indexPath.row].description
      } else {
        let indexPath = self.tableView.indexPathForSelectedRow()!
        let destinationTitle = self.products[indexPath.row].title
        productDetailViewController.title = destinationTitle
        productDetailViewController.productPriceText = String(self.products[indexPath.row].title)
        productDetailViewController.productTitleText = self.products[indexPath.row].title
        productDetailViewController.productDescriptionText = self.products[indexPath.row].description
      }
      
     
     
    }
  }


  @IBAction func SellSwipe(sender: AnyObject) {
    println("Swiped from buy to main")
    let mainView = self.storyboard?.instantiateViewControllerWithIdentifier("mainController") as ViewController
    self.navigationController?.pushViewController(mainView, animated: true)
  }
  
  
}
