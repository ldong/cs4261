//
//  BuyTreeViewController.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/5/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import UIKit

class BuyTreeViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
  
    var products : [Product] = []
    var filteredProducts = [Product]()
  
    override func viewDidLoad() {
      
      self.products = [
        Product(name:"Chocolate", price: 11, description: "i"),
        Product(name:"Candy", price: 12, description: "h"),
        Product(name:"Break", price: 13, description: "g"),
        Product(name:"Apple", price: 14, description: "f"),
        Product(name:"Computer", price: 15, description: "e"),
        Product(name:"Laptop", price: 16, description: "d"),
        Product(name:"Cup", price: 17, description: "c"),
        Product(name:"Table", price: 18, description: "b"),
        Product(name:"Chair", price: 19, description: "a")
      ]
      
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
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
    cell.textLabel!.text = product.name
    cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    
    return cell
  }
  
  func filterContentForSearchText(searchText: String, scope: String = "All") {
    self.filteredProducts = self.products.filter(
      {
        ( product : Product) -> Bool in
        var categoryMatch = (scope == "All") || (product.category == scope)
        var stringMatch = product.name.rangeOfString(searchText)
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
        let destinationTitle = self.filteredProducts[indexPath.row].name
        productDetailViewController.title = destinationTitle
      } else {
        let indexPath = self.tableView.indexPathForSelectedRow()!
        let destinationTitle = self.products[indexPath.row].name
        productDetailViewController.title = destinationTitle
      }
      

//      productDetailViewController.productPriceText = "10"
//      productDetailViewController.productTitleText = "100"
//      productDetailViewController.productDescriptionText = "100"
    }
  }
  
  
  @IBAction func SellSwipe(sender: AnyObject) {
    println("Swiped from buy to main")
    let mainView = self.storyboard?.instantiateViewControllerWithIdentifier("mainController") as ViewController
    self.navigationController?.pushViewController(mainView, animated: true)
  }


}