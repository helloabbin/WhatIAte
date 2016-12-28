//
//  WIAItem.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 20/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit
import Photos

class WIAItem: NSObject {
    
    var name: String
    
    var price: Double
    
    var cuisine: WIACuisine
    
    var shortDescription: String?
   
    var place: WIAPlace?
    
    var images: [PHAsset]?
    
    init(name: String, price: Double, cuisine:WIACuisine, shortDescription: String?) {
        self.name = name
        self.price = price
        self.cuisine = cuisine
        self.shortDescription = shortDescription
    }
}
