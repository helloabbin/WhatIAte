//
//  WIAPlace.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 21/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit
import CoreLocation

class WIAPlace: NSObject {
    
    var name: String
    
    var address: String
    
    var location: CLLocation
    
    var phoneNumbers: [Int]?
    
    var cappedName: String {
        get {
            let trimmed = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let superTrimmed = trimmed.replacingOccurrences(of: " ", with: "")
            let capped = superTrimmed.lowercased()
            return capped
        }
    }
    
    init(name: String, address: String, location: CLLocation, phoneNumbers: Array<Int>?) {
        self.name = name
        self.address = address
        self.location = location
        self.phoneNumbers = phoneNumbers
    }
}
