//
//  WIATextViewCellTableViewCell.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 14/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

@objc protocol WIATextViewCellTableViewCellDelegate {
    
    @objc optional func WIATextViewCellTableViewCellDidChangeEditing(_ cell: WIATextViewCellTableViewCell, with text: String, with indexPath: IndexPath)
}

class WIATextViewCellTableViewCell: UITableViewCell, UITextViewDelegate {

    var cellIndexPath: IndexPath?
    var delegate: WIATextViewCellTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let trimmed = textView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        delegate?.WIATextViewCellTableViewCellDidChangeEditing?(self, with: trimmed, with: cellIndexPath!)
    }
    
}
