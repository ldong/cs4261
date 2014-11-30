//
//  User.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/5/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import Foundation

class User {

  var email: String
    var _id:String
  
    init(email: String, _id: String) {
    self.email = email
        self._id = _id
  }
}