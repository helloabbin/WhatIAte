//
//  WIAManager.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 15/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit
import Photos

class WIAManager: NSObject {
    
    class func searchForItem(searchText:String, completion:(_ results: [WIAItem], _ searchedText: String) -> Void) {
        completion([], searchText.trimmed)
    }
    
    class func searchForPlace(searchText:String, completion:(_ results: [WIAPlace], _ searchedText: String) -> Void) {
        completion([], searchText.trimmed)
    }
    
    class func searchForCuisine(searchText:String, completion:(_ results: [WIACuisine], _ searchedText: String) -> Void) {
        completion([], searchText.trimmed)
    }
    
    class func saveItem(item: WIAItem, rating: Double, review: String, images: [PHAsset], completion:(_ completed: Bool, _ item: WIAItem, _ error: Error) -> Void) {
        
    }
    
}

extension String {
    
    var trimmed: String {
        get {
            return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var superTrimmed: String {
        get {
            return trimmed.replacingOccurrences(of: " ", with: "")
        }
    }
    
    var capped: String {
        get {
            return superTrimmed.lowercased()
        }
    }
    
    var priceValue: Double {
        get {
            return Double(trimmed.replacingOccurrences(of: NSLocale.current.currencySymbol!, with: ""))!
        }
    }
    
}
