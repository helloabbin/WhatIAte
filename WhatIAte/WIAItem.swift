//
//  WIAItem.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 20/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

class WIAItem: NSObject {
    
    var itemName: String
    var itemPrice: Double
    var itemCuisine: WIACuisine
    var itemDescription: String
    
    override init() {
        itemName = ""
        itemPrice = 0.0
        itemCuisine = WIACuisine()
        itemDescription = ""
    }
}
