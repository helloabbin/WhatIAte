//
//  WIATextFieldTableViewCell.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 14/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

@objc protocol WIATextFieldTableViewCellDelegate {
    
    @objc optional func WIATextFieldTableViewCellDidChangeEditing(_ cell: WIATextFieldTableViewCell, with indexPath: IndexPath)
    
    @objc optional func WIATextFieldTableViewCellShouldBeginEditing(_ cell: WIATextFieldTableViewCell, with indexPath: IndexPath) -> Bool
    
    @objc optional func WIATextFieldTableViewCellDidBeginEditing(_ cell: WIATextFieldTableViewCell, with indexPath: IndexPath)
    @objc optional func WIATextFieldTableViewCellDidEndEditing(_ cell: WIATextFieldTableViewCell, with indexPath: IndexPath)
    
    @objc optional func WIATextFieldTableViewCell(_ cell: WIATextFieldTableViewCell, shouldChangeCharactersIn range: NSRange, replacementString string: String, with indexPath: IndexPath) -> Bool
}

class WIATextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var celltextField: UITextField!
    
    var cellIndexPath: IndexPath?
    var delegate: WIATextFieldTableViewCellDelegate?
    
    var cellKeyboardType: UIKeyboardType! {
        didSet {
            celltextField.keyboardType = cellKeyboardType
        }
    }
    
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
        celltextField.keyboardType = UIKeyboardType.default
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if  let bool = delegate?.WIATextFieldTableViewCellShouldBeginEditing?(self, with: cellIndexPath!){
            return bool
        }
        else{
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.WIATextFieldTableViewCellDidBeginEditing?(self, with: cellIndexPath!)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.WIATextFieldTableViewCellDidEndEditing?(self, with: cellIndexPath!)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let bool = delegate?.WIATextFieldTableViewCell?(self, shouldChangeCharactersIn: range, replacementString: string, with: cellIndexPath!) {
            return bool
        }
        else{
            return true
        }
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        delegate?.WIATextFieldTableViewCellDidChangeEditing?(self, with: cellIndexPath!)
    }
    
}
