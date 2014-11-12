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
  var _id: String = "nil "
  var __v: Int = 0
  var price: Double = 0
  var description: String = "nil "
  var created: String = "nil "
  var name: String = "nil "
  var user: StructUser!

    init() {
  }
  init(_ decoder: JSONDecoder) {
    println("===decoder from Item============")
 
    _id = decoder["_id"].string!
    
    __v = decoder["__v"].integer!
    
    price = decoder["price"].double!

    
    description = decoder["description"].string!
  
    created = decoder["description"].string!
    
  
    name = decoder["description"].string!
    
    if var u = StructUser(decoder["user"])._id{
    user = StructUser(decoder["user"])
    }
    
  }
  
}


