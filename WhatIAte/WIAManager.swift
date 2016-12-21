//
//  WIAManager.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 15/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

class WIAManager: NSObject {
    
    class func searchForItem(searchText:String, completion:(_ results: [WIAItem], _ searchedText: String) -> Void) {
        let trimmed = searchText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//        let superTrimmed = trimmed.replacingOccurrences(of: " ", with: "")
//        let capped = superTrimmed.lowercased()
        completion([], trimmed)
    }
    
    class func searchForPlace(searchText:String, completion:(_ results: [WIAPlace], _ searchedText: String) -> Void) {
        let trimmed = searchText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//        let superTrimmed = trimmed.replacingOccurrences(of: " ", with: "")
//        let capped = superTrimmed.lowercased()
        completion([], trimmed)
    }
    
    class func searchForCuisine(searchText:String, completion:(_ results: [WIACuisine], _ searchedText: String) -> Void) {
        let trimmed = searchText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//        let superTrimmed = trimmed.replacingOccurrences(of: " ", with: "")
//        let capped = superTrimmed.lowercased()
        completion([], trimmed)
    }
    
}
