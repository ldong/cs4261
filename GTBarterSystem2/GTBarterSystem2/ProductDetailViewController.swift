//
//  ProductDetailViewController.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/5/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

  @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
  @IBOutlet weak var connectUserButton: UIButton!
  
  var productDescriptionText: String = ""
  var productPriceText: String = ""
  var productTitleText: String = ""

  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        productDescription.text = productDescriptionText
        productPrice.text = productPriceText
//        productTitle.text = productTitleText
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  @IBAction func contactUserClicked(sender: AnyObject) {
    println("conentUserButton clicked")
  }

}
