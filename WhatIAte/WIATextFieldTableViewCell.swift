//
//  WIATextFieldTableViewCell.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 14/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

protocol WIATextFieldTableViewCellDelegate : NSObjectProtocol {

    func WIATextFieldTableViewCell(_ cell: WIATextFieldTableViewCell, shouldBeginEditingRowAt indexPath: IndexPath) -> Bool

}

class WIATextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var celltextField: UITextField!
    
    var cellIndexPath: IndexPath?
    var delegate: WIATextFieldTableViewCellDelegate?
    
    var cellPlaceHolder: String! {
        didSet {
            celltextField.placeholder = cellPlaceHolder
        }
    }
    
    var cellText: String! {
        didSet {
            celltextField.text = cellText
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellIndexPath = nil
        delegate = nil
        celltextField.placeholder = ""
        celltextField.text = ""
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let delegate = self.delegate {
            return delegate.WIATextFieldTableViewCell(self, shouldBeginEditingRowAt: cellIndexPath!)
        }
        else{
            return true
        }
    }
    
}
