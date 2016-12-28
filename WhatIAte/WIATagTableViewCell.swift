//
//  WIATagTableViewCell.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 16/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

class WIATagTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var tagView: TLTagsControl!
    
    var cellPlaceHolder: String? {
        didSet {
            tagView.tagPlaceholder = cellPlaceHolder
        }
    }
    
}
