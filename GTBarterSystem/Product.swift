//
//  Product.swift
//  GTBarterSystem
//
//  Created by Haytham Abutair on 10/4/14.
//  Copyright (c) 2014 Haytham Abutair. All rights reserved.
//

import Foundation

public class Product {
    
    var title = "";
    var description = "";
    var price:Double = 0;
    
    init(title:String, description:String, price:Double)
    {
        self.title = title
        self.description = description
        self.price = price
    }
        
    
    
}