//
//  UserStruct.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/20/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import Foundation
import JSONJoy

struct StructUser : JSONJoy{
  var _id: String?
  var email: String?
  init(){
  }
  
  init(_ decoder: JSONDecoder) {
    _id = decoder["_id"].string
    email = decoder["displayName"].string
    println(email)
  }
}