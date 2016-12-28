//
//  WIAColor.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 13/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

class WIAColor: UIColor {
    
    open class var openGreen: UIColor {
        get {
            return UIColor.init(red: 76/255, green: 175/255, blue: 80/255, alpha: 1)
        }
    }
    
    open class var mainColor: UIColor {
        get {
            return UIColor.init(red: 88/255, green: 86/255, blue: 214/255, alpha: 1)
        }
    }
    
    open class func colorFor(Value : CGFloat) -> UIColor {
        if Value > 9 {
            return UIColor.init(red: 42/255, green: 82/255, blue: 6/255, alpha: 1.0)
        }
        else if Value > 8 {
            return UIColor.init(red: 55/255, green: 115/255, blue: 1/255, alpha: 1.0)
        }
        else if Value > 7 {
            return UIColor.init(red: 81/255, green: 158/255, blue: 37/255, alpha: 1.0)
        }
        else if Value > 6 {
            return UIColor.init(red: 143/255, green: 197/255, blue: 44/255, alpha: 1.0)
        }
        else if Value > 5 {
            return UIColor.init(red: 198/255, green: 208/255, blue: 21/255, alpha: 1.0)
        }
        else if Value > 4 {
            return UIColor.init(red: 255/255, green: 208/255, blue: 5/255, alpha: 1.0)
        }
        else if Value > 3 {
            return UIColor.init(red: 255/255, green: 177/255, blue: 5/255, alpha: 1.0)
        }
        else if Value > 2 {
            return UIColor.init(red: 255/255, green: 108/255, blue: 3/255, alpha: 1.0)
        }
        else if Value > 1 {
            return UIColor.init(red: 217/255, green: 27/255, blue: 17/255, alpha: 1.0)
        }
        else {
            return UIColor.init(red: 198/255, green: 26/255, blue: 34/255, alpha: 1.0)
        }
    }
    
}
