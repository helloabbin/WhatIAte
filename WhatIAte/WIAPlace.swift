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
    
    var phoneNumbers: [String]?
    
    init(name: String, address: String, location: CLLocation, phoneNumbers: [String]?) {
        self.name = name
        self.address = address
        self.location = location
        self.phoneNumbers = phoneNumbers
    }
}
