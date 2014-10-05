//
//  BuyPageController.swift
//  GTBarterSystem
//
//  Created by Haytham Abutair on 10/4/14.
//  Copyright (c) 2014 Haytham Abutair. All rights reserved.
//

import UIKit

class BuyPageController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var arrayOfProduct:[Product] = [Product]()


    @IBOutlet weak var buyProductsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getProductsFromServer()
               
        
     

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfProduct.count
        
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell:CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell") as CustomCell
        //we can add background colors here if we want
        let product = arrayOfProduct[indexPath.row]
        cell.productTitle.text = product.title
        cell.productDescription.text = product.description
        cell.setCell(product.title, description: product.description)
        return cell
        
    }

    
    
    func getProductsFromServer(){
        //Lin this is where we would need to make the restful call
        
        var currProduct = Product(title: "Product Title1", description: "Description of product1", price: 15.45)
        var currProduct2 = Product(title: "Product Title2", description: "Description of product2", price: 50.60)
        
        arrayOfProduct.append(currProduct)
        arrayOfProduct.append(currProduct2)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
