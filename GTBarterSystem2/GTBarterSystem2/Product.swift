//
//  Product.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/5/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import Foundation

class Product {
  
  var _id: String
  var __v: Int
  var price: Double
  var description: String
  var created: String
  var title: String
  var user: User
  var name: String
  var category: String
  
  init(title: String, price:Double, description: String){
    self.title = title
    self.price = price
    self.description = description
    self.name = " name"
    self._id = " id 1"
    self.__v = 1
    self.category = " cat 1 "
    self.created = " created "
    var use = User(email: "email")
    self.user = use
  }
  
  
  init(_id:String, __v:Int, price:Double, created:String, title:String, description: String, category:String, user:User) {
    self.title = title
    self.price = price
    self.description = description
    self.category = "All"
    self.__v = __v
    self._id = _id
    self.created = created
    self.user = user
    self.name = " name"
    
  }
  
  func descrpiton() -> String {
    return "\(self.title) is \(price), and desc \(description)"
  }
}