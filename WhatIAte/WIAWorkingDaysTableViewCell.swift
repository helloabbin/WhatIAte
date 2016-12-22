//
//  WIAWorkingDaysTableViewCell.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 16/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

protocol WIAWorkingDaysTableViewCellDelegate {
    
    func WIAWorkingDaysTableViewCellDidChangeStatus(cell: WIAWorkingDaysTableViewCell, status: Bool, indexPath: IndexPath)
    
}

class WIAWorkingDaysTableViewCell: UITableViewCell {

    var cellIndexPath: IndexPath!
    var delegate: WIAWorkingDaysTableViewCellDelegate?
    
    @IBOutlet weak var cellSwitch: UISwitch!
    @IBOutlet weak var cellTextLabel: UILabel!
    
    var cellText: String? {
        didSet {
            cellTextLabel.text = cellText
        }
    }
    
    var isOn: Bool {
        get {
            return cellSwitch.isOn
        }
        set {
            cellSwitch.isOn = newValue
        }
    }
    
    @IBAction func switchDidChangeValue(_ sender: UISwitch) {
        delegate?.WIAWorkingDaysTableViewCellDidChangeStatus(cell: self, status: sender.isOn, indexPath: cellIndexPath)
    }

}
