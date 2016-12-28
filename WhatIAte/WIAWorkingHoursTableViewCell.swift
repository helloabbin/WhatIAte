//
//  WIAWorkingHoursTableViewCell.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 19/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

class WIAWorkingHoursTableViewCell: UITableViewCell {

    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var tillTextField: UITextField!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var tillLabel: UILabel!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var tillView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchDidChangeValue(_ sender: UISwitch) {
        if sender.isOn {
            let alpha: CGFloat = 0.5
            fromLabel.alpha = alpha
            tillLabel.alpha = alpha
            fromView.alpha = alpha
            tillView.alpha = alpha
            
            fromView.isUserInteractionEnabled = false
            tillView.isUserInteractionEnabled = false
        }
        else{
            fromLabel.alpha = 1
            tillLabel.alpha = 1
            fromView.alpha = 1
            tillView.alpha = 1
            
            fromView.isUserInteractionEnabled = true
            tillView.isUserInteractionEnabled = true
        }
    }
    
    var fromInputView: UIView? {
        get {
            return fromTextField.inputView
        }
        set {
            fromTextField.inputView = newValue
        }
    }
    
    var tillInputView: UIView? {
        get {
            return tillTextField.inputView
        }
        set {
            tillTextField.inputView = newValue
        }
    }
    
    var fromText: String? {
        get {
            return fromTextField.text
        }
        set {
            fromTextField.text = newValue
        }
    }
    
    var tillText: String? {
        get {
            return tillTextField.text
        }
        set {
            tillTextField.text = newValue
        }
    }
}
