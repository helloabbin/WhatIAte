//
//  WIAManager.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 15/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit
import CloudKit

class WIAManager: NSObject {
    
    class func searchForItemWith(input: String, completion: (_ results: [WIAItem], _ searchedText: String) -> Void) {
        let trimmed = input.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//        let superTrimmed = trimmed.replacingOccurrences(of: " ", with: "")
//        let capped = superTrimmed.lowercased()
        completion([], trimmed)
    }
    
    class func searchForPlaceWith(input: String, completion: (_ results: [WIAItem], _ searchedText: String) -> Void) {
        let trimmed = input.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        //        let superTrimmed = trimmed.replacingOccurrences(of: " ", with: "")
        //        let capped = superTrimmed.lowercased()
        completion([], trimmed)
    }
    
}
