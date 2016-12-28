//
//  WIATextFieldTableViewCell.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 14/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

@objc protocol WIATextFieldTableViewCellDelegate {
    
    @objc optional func WIATextFieldTableViewCellDidChangeEditing(cell: WIATextFieldTableViewCell, indexPath: IndexPath)
    
    @objc optional func WIATextFieldTableViewCellShouldBeginEditing(cell: WIATextFieldTableViewCell, indexPath: IndexPath) -> Bool
    
    @objc optional func WIATextFieldTableViewCellDidBeginEditing(cell: WIATextFieldTableViewCell, indexPath: IndexPath)
    
    @objc optional func WIATextFieldTableViewCellDidEndEditing(cell: WIATextFieldTableViewCell, indexPath: IndexPath)
    
    @objc optional func WIATextFieldTableViewCell(cell: WIATextFieldTableViewCell, shouldChangeCharactersIn range: NSRange, replacementString string: String, indexPath: IndexPath) -> Bool
}

class WIATextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var celltextField: UITextField!
    
    var cellIndexPath: IndexPath!
    var delegate: WIATextFieldTableViewCellDelegate?
    
    var cellKeyboardType: UIKeyboardType {
        get {
            return celltextField.keyboardType
        }
        set {
            celltextField.keyboardType = newValue
        }
    }
    
    var cellPlaceHolder: String? {
        didSet {
            celltextField.placeholder = cellPlaceHolder
        }
    }
    
    var cellText: String? {
        get {
            return celltextField.text?.trimmed
        }
        set {
            celltextField.text = newValue
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
        if  let bool = delegate?.WIATextFieldTableViewCellShouldBeginEditing?(cell: self, indexPath: cellIndexPath) {
            return bool
        }
        else{
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.WIATextFieldTableViewCellDidBeginEditing?(cell: self, indexPath: cellIndexPath)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.WIATextFieldTableViewCellDidEndEditing?(cell: self, indexPath: cellIndexPath)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let bool = delegate?.WIATextFieldTableViewCell?(cell: self, shouldChangeCharactersIn: range, replacementString: string, indexPath: cellIndexPath) {
            return bool
        }
        else{
            return true
        }
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        delegate?.WIATextFieldTableViewCellDidChangeEditing?(cell: self, indexPath: cellIndexPath)
    }
    
}
