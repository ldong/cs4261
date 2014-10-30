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
  
  var descritpiton : String {
    return "Hi"
  }
  
  init() {
  }
  init(_ decoder: JSONDecoder) {
    println("decoder from Items============")
//    println(decoder.array)
//    decoder.array(&items)
    items = Array<Item>()
    for index in 0..<decoder.array!.count {
//      println("\(index)  \(decoder[index])")
      items?.append(Item(decoder[index]))
    }
  }

}