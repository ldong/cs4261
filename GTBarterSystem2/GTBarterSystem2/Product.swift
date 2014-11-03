//
//  Product.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/5/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import Foundation

class Product {
  
  var title: String
  var price: Int
  var category: String
  var description: String
  var timestamp :NSDate
  
  init(title:String, price: Int, description: String) {
    self.title = title
    self.price = price
    self.description = description
    self.category = "All"
    timestamp = NSDate()
  }

  func descrpiton() -> String {
    return "\(self.title) is \(price), and desc \(description)"
  }
}