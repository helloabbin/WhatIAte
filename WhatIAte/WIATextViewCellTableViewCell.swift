//
//  WIATextViewCellTableViewCell.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 14/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

protocol WIATextViewCellTableViewCellDelegate {
    
    func WIATextViewCellTableViewCellDidChangeEditing(cell: WIATextViewCellTableViewCell, string: String, with indexPath: IndexPath)

}

class WIATextViewCellTableViewCell: UITableViewCell, UITextViewDelegate {

    var cellIndexPath: IndexPath!
    var delegate: WIATextViewCellTableViewCellDelegate?
    
    func textViewDidChange(_ textView: UITextView) {
        let trimmed = textView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        delegate?.WIATextViewCellTableViewCellDidChangeEditing(cell: self, string: trimmed, with: cellIndexPath)
    }
    
}
