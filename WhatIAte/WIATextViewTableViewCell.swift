//
//  WIATextViewTableViewCell.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 23/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

protocol WIATextViewTableViewCellDelegate {
    func WIATextViewCellDidChange(cell: WIATextViewTableViewCell, text: String, indexPath: IndexPath)
}

class WIATextViewTableViewCell: UITableViewCell, UITextViewDelegate {

    var cellIndexPath: IndexPath!
    var delegate: WIATextViewTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textViewDidChange(_ textView: UITextView) {
        delegate?.WIATextViewCellDidChange(cell: self, text: textView.text.trimmed, indexPath: cellIndexPath)
    }
    
}
