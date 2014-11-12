//
//  User.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/5/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import Foundation

class User {

  let email: String
    var id:String
    
  lazy var products : [String: Product] = [String: Product]()
  
    init(email: String, id:String) {
    self.email = email
    self.id = id
  }

  func addProduct(p: Product) -> [String:Product] {
    products.updateValue(p, forKey: p.title)
    return products
  }
  
  func removeProduct(p: Product) -> [String:Product] {
    products.removeValueForKey(p.title)
    return products
  }
}