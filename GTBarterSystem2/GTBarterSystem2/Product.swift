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
  var description: String

  init(name:String, price: Int, description: String) {
    self.name = name
    self.price = price
    self.description = description
  }

  func descrpiton() -> String {
    return "\(self.name) is \(price), and desc \(description)"
  }
}