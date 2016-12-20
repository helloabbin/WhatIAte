//
//  WIAMakeItemViewController.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 15/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

class WIAMakeItemViewController: UITableViewController, WIATextFieldTableViewCellDelegate {

    enum WIAMakeItemViewControllerSection: Int {
        case name = 0
        case price = 1
        case cuisine = 2
        case description = 3
    }
    
    var delegate: WIAChooseItemViewControllerDelegate?
    var itemName : String?
    var itemObject = WIAItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemObject.itemName = itemName!
        
        tableView.keyboardDismissMode = .interactive
        tableView.register(UINib.init(nibName: "WIATextViewCellTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIATextViewCellTableViewCell")
        tableView.register(UINib.init(nibName: "WIATextFieldTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIATextFieldTableViewCell")
        
        let saveButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func doneButtonClicked() {
        dismiss(animated: true, completion: {
            if let delegate = self.delegate {
                let controller : WIAChooseItemViewController = self.navigationController?.viewControllers.first as! WIAChooseItemViewController
                delegate.WIAChooseItemViewController(controller, didFinishPickingItem: self.itemObject)
            }
        })
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == WIAMakeItemViewControllerSection.name.rawValue {
            let cell : WIATextFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIATextFieldTableViewCell", for: indexPath) as! WIATextFieldTableViewCell
            cell.delegate = self
            cell.cellIndexPath = indexPath
            cell.cellPlaceHolder = "type here"
            cell.cellText = itemName
            return cell
        }
        else if indexPath.section == WIAMakeItemViewControllerSection.price.rawValue {
            let cell : WIATextFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIATextFieldTableViewCell", for: indexPath) as! WIATextFieldTableViewCell
            cell.delegate = self
            cell.cellIndexPath = indexPath
            cell.cellPlaceHolder = "type here"
            return cell
        }
        else if indexPath.section == WIAMakeItemViewControllerSection.cuisine.rawValue {
            let cell : WIATextFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIATextFieldTableViewCell", for: indexPath) as! WIATextFieldTableViewCell
            cell.delegate = self
            cell.cellIndexPath = indexPath
            cell.cellPlaceHolder = "add a cuisine"
            return cell
        }
        else{
            let cell : WIATextViewCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIATextViewCellTableViewCell", for: indexPath) as! WIATextViewCellTableViewCell
            return cell
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case WIAMakeItemViewControllerSection.name.rawValue:
            return "Name of the item"
        case WIAMakeItemViewControllerSection.price.rawValue:
            return "How much do it cost"
        case WIAMakeItemViewControllerSection.cuisine.rawValue:
            return "Cuisine"
        case WIAMakeItemViewControllerSection.description.rawValue:
            return "Give a short description (optional)"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case WIAMakeItemViewControllerSection.name.rawValue:
            return 44
        case WIAMakeItemViewControllerSection.price.rawValue:
            return 44
        case WIAMakeItemViewControllerSection.cuisine.rawValue:
            return 44
        case WIAMakeItemViewControllerSection.description.rawValue:
            return 100
        default:
            return 44
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - WIATextFieldTableViewCellDelegate
    
    func WIATextFieldTableViewCell(_ cell: WIATextFieldTableViewCell, shouldBeginEditingRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case WIAMakeItemViewControllerSection.name.rawValue, WIAMakeItemViewControllerSection.price.rawValue:
            return true
        default:
            return false
        }
    }

}
