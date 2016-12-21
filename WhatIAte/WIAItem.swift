//
//  WIAItem.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 20/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

class WIAItem: NSObject {
    
    var name: String
    
    var price: Double
    
    var cuisine: WIACuisine
    
    var shortDescription: String
    
    var cappedName: String {
        get {
            let trimmed = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let superTrimmed = trimmed.replacingOccurrences(of: " ", with: "")
            let capped = superTrimmed.lowercased()
            return capped
        }
    }
    
    init(name: String, price: Double, cuisine:WIACuisine, shortDescription: String?) {
        self.name = name
        self.price = price
        self.cuisine = cuisine
        if let optionalShortDescription = shortDescription {
            self.shortDescription = optionalShortDescription
        }
        else{
            self.shortDescription = ""
        }
    }
}
