//
//  Items.swift
//  GTBarterSystem2
//
//  Created by Lin Dong on 10/20/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

import Foundation
import JSONJoy

struct Items: JSONJoy{
  var items: Array<Item>?
  init() {
  }
  init(_ decoder: JSONDecoder) {
    decoder.array(&items)
  }
}