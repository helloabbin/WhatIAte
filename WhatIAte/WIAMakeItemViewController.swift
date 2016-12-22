//
//  WIAMakeItemViewController.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 15/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

class WIAMakeItemViewController: UITableViewController, WIATextFieldTableViewCellDelegate, WIATextViewCellTableViewCellDelegate, WIACuisineViewControllerDelegate {
    
    enum WIAMakeItemViewControllerSection: Int {
        case name
        case price
        case cuisine
        case description
    }
    
    var delegate: WIAChooseItemViewControllerDelegate!
    
    var itemName : String!
    var itemPrice : Double!
    var itemCuisine : WIACuisine!
    var itemDescription : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.keyboardDismissMode = .interactive
        tableView.register(UINib.init(nibName: "WIATextViewCellTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIATextViewCellTableViewCell")
        tableView.register(UINib.init(nibName: "WIATextFieldTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIATextFieldTableViewCell")
        
        let saveButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WIACuisineViewControllerSegue" {
            let nav : UINavigationController = segue.destination as! UINavigationController
            let controller : WIACuisineViewController = nav.viewControllers.first as! WIACuisineViewController
            controller.delegate = self
        }
    }
    
    func doneButtonClicked() {
        if itemName == nil {
            let alert = UIAlertController.init(title: "Name missing?", message: "Please enter Name of the Item", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else if itemPrice == nil {
            let alert = UIAlertController.init(title: "Price missing?", message: "Please enter Price of the Item", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else if itemCuisine == nil {
            let alert = UIAlertController.init(title: "Cuisine missing?", message: "Please enter Item Cuisine", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else{
            tableView.endEditing(false)
            dismiss(animated: true, completion: {
                if let delegate = self.delegate {
                    let item = WIAItem(name: self.itemName!, price: self.itemPrice!, cuisine: self.itemCuisine!, shortDescription: self.itemDescription)
                    let controller : WIAChooseItemViewController = self.navigationController!.viewControllers.first as! WIAChooseItemViewController
                    delegate.WIAChooseItemViewController(controller: controller, didFinishWith: item)
                }
            })
        }
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
            cell.cellKeyboardType = UIKeyboardType.decimalPad
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
            cell.delegate = self
            cell.cellIndexPath = indexPath
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
    
    func WIATextFieldTableViewCellShouldBeginEditing(cell: WIATextFieldTableViewCell, indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case WIAMakeItemViewControllerSection.name.rawValue, WIAMakeItemViewControllerSection.price.rawValue:
            return true
        case WIAMakeItemViewControllerSection.cuisine.rawValue:
            performSegue(withIdentifier: "WIACuisineViewControllerSegue", sender: self)
            return false
        default:
            return false
        }
    }
    
    func WIATextFieldTableViewCellDidChangeEditing(cell: WIATextFieldTableViewCell, indexPath: IndexPath) {
        switch indexPath.section {
        case WIAMakeItemViewControllerSection.name.rawValue:
            itemName = cell.cellText
        case WIAMakeItemViewControllerSection.price.rawValue:
            let superTrimmed = cell.cellText?.replacingOccurrences(of: NSLocale.current.currencySymbol!, with: "")
            itemPrice = Double(superTrimmed!)
        default:
            break
        }
    }
    
    func WIATextFieldTableViewCellDidBeginEditing(cell: WIATextFieldTableViewCell, indexPath: IndexPath) {
        if indexPath.section == WIAMakeItemViewControllerSection.price.rawValue {
            if cell.cellText == "" {
                cell.cellText = NSLocale.current.currencySymbol
            }
        }
    }
    
    func WIATextFieldTableViewCellDidEndEditing(cell: WIATextFieldTableViewCell, indexPath: IndexPath) {
        if indexPath.section == WIAMakeItemViewControllerSection.price.rawValue {
            if cell.cellText == NSLocale.current.currencySymbol {
                cell.cellText = ""
            }
        }
    }
    
    func WIATextFieldTableViewCell(cell: WIATextFieldTableViewCell, shouldChangeCharactersIn range: NSRange, replacementString string: String, indexPath: IndexPath) -> Bool {
        if indexPath.section == WIAMakeItemViewControllerSection.price.rawValue {
            if (range.location == 0 && range.length == 1) || (range.location > 6 && range.length == 0) {
                return false
            }
            else{
                return true
            }
        }
        else{
            return true
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - WIATextViewCellTableViewCellDelegate
    
    func WIATextViewCellTableViewCellDidChangeEditing(cell: WIATextViewCellTableViewCell, string: String, with indexPath: IndexPath) {
        itemDescription = string
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - WIACuisineViewControllerDelegate
    
    func WIACuisineViewController(controller: WIACuisineViewController, didFinishWith cuisine: WIACuisine) {
        itemCuisine = cuisine
        let cell : WIATextFieldTableViewCell = tableView.cellForRow(at: IndexPath(row: 0, section: WIAMakeItemViewControllerSection.cuisine.rawValue)) as! WIATextFieldTableViewCell
        cell.cellText = itemCuisine.name
    }
    
}
