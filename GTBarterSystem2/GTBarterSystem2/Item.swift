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
  var price: Double?
  var description: String?
  var created: String?
  var name: String?
  var user: StructUser?
  init() {
  }
  init(_ decoder: JSONDecoder) {
    _id = decoder["_id"].string
//    __v = decoder["__v"].integer
//    price = decoder["price"].double
//    description = decoder["description"].string
//    created = decoder["description"].string
//    name = decoder["description"].string
//    user = StructUser(decoder["user"])
  }
}


