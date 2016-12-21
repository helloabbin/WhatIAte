//
//  WIACuisine.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 20/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

class WIACuisine: NSObject {
    
    var name : String
    
    var cappedName: String {
        get {
            let trimmed = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let superTrimmed = trimmed.replacingOccurrences(of: " ", with: "")
            let capped = superTrimmed.lowercased()
            return capped
        }
    }
    
    init(name: String) {
        self.name = name
    }
}
