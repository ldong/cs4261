//
//  Product.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/5/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import Foundation

class Product {
  
  var name: String
  var price: Int
  var category: String
  var description: String

  init(name:String, price: Int, description: String) {
    self.name = name
    self.price = price
    self.description = description
    self.category = "All"
  }

  func descrpiton() -> String {
    return "\(self.name) is \(price), and desc \(description)"
  }
}