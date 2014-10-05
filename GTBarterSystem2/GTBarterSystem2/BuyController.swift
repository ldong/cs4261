//
//  BuyController.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/5/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import UIKit

class BuyController: UIViewController, UISearchBarDelegate {

  @IBOutlet weak var searchBar: UISearchBar!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func buySwipe(sender: AnyObject) {
    println("Swiped from buy to main")
    let mainView = self.storyboard?.instantiateViewControllerWithIdentifier("mainController") as ViewController
    self.navigationController?.pushViewController(mainView, animated: true)
  }
  
}
