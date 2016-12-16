//
//  WIAWorkingDaysTableViewCell.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 16/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

protocol WIAWorkingDaysTableViewCellDelegate {
    
    func WIAWorkingDaysTableViewCell(cell : WIAWorkingDaysTableViewCell, didChange status : Bool, at indexPath : IndexPath)
    
}

class WIAWorkingDaysTableViewCell: UITableViewCell {

    var cellIndexPath: IndexPath?
    var delegate: WIAWorkingDaysTableViewCellDelegate?
    
    @IBOutlet weak var cellSwitch: UISwitch!
    @IBOutlet weak var cellTextLabel: UILabel!
    
    @IBAction func switchDidChangeValue(_ sender: UISwitch) {
        if let delegate = self.delegate {
            return delegate.WIAWorkingDaysTableViewCell(cell: self, didChange: sender.isOn, at: cellIndexPath!)
        }
    }
    
    var cellText: String! {
        didSet {
            cellTextLabel.text = cellText
        }
    }
    
    var isOn: Bool! {
        didSet {
            cellSwitch.isOn = isOn
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
