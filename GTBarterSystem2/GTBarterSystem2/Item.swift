//
//  Item.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/20/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import Foundation
import JSONJoy


struct Item: JSONJoy{
  var _id: String?
  var __v: Int?
  var price: Int?
  var description: String?
  var created: String?
  var name: String?
  var user: StructUser?
  var category: String?
  init() {
  }
  init(_ decoder: JSONDecoder) {
    println(decoder)
    _id = decoder["_id"].string
    __v = decoder["__v"].integer
    price = decoder["price"].integer
    description = decoder["description"].string
    created = decoder["created"].string
    name = decoder["name"].string
    user = StructUser(decoder["user"])
    category = decoder["category"].string
  }
  
}


