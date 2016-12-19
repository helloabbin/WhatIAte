//
//  WIAMakePlaceViewController.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 16/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

class WIAMakePlaceViewController: UITableViewController, WIATextFieldTableViewCellDelegate, TLTagsControlDelegate, WIAWorkingDaysTableViewControllerDelegate {
    
    enum WIAMakePlaceViewControllerSection: Int {
        case name = 0
        case address = 1
        case coordinates = 2
        case phoneNumber = 3
        case workingDays = 4
        case workinghours = 5
    }
    
    var placeName : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.keyboardDismissMode = .interactive
        
        tableView.register(UINib.init(nibName: "WIATextFieldTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIATextFieldTableViewCell")
        tableView.register(UINib.init(nibName: "WIATagTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIATagTableViewCell")
        
        let saveButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func doneButtonClicked() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WIAWorkingDaysTableViewControllerSegue" {
            let nav : UINavigationController = segue.destination as! UINavigationController
            let controller : WIAWorkingDaysTableViewController = nav.viewControllers.first as! WIAWorkingDaysTableViewController
            controller.delegate = self
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == WIAMakePlaceViewControllerSection.name.rawValue {
            let cell : WIATextFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIATextFieldTableViewCell", for: indexPath) as! WIATextFieldTableViewCell
            cell.delegate = self
            cell.cellIndexPath = indexPath
            cell.cellPlaceHolder = "type here"
            cell.cellText = placeName
            return cell
        }
        else if indexPath.section == WIAMakePlaceViewControllerSection.address.rawValue {
            let cell : WIATextFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIATextFieldTableViewCell", for: indexPath) as! WIATextFieldTableViewCell
            cell.delegate = self
            cell.cellIndexPath = indexPath
            cell.cellPlaceHolder = "type here"
            return cell
        }
        else if indexPath.section == WIAMakePlaceViewControllerSection.coordinates.rawValue {
            let cell : WIATextFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIATextFieldTableViewCell", for: indexPath) as! WIATextFieldTableViewCell
            cell.delegate = self
            cell.cellIndexPath = indexPath
            cell.cellPlaceHolder = "tap here"
            return cell
        }
        else if indexPath.section == WIAMakePlaceViewControllerSection.phoneNumber.rawValue {
            let cell : WIATagTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIATagTableViewCell", for: indexPath) as! WIATagTableViewCell
            cell.tagView.tapDelegate = self
            cell.tagView.tagIndexPath = indexPath
            return cell
        }
        else if indexPath.section == WIAMakePlaceViewControllerSection.workingDays.rawValue {
            let cell : WIATagTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIATagTableViewCell", for: indexPath) as! WIATagTableViewCell
            cell.tagView.tapDelegate = self
            cell.tagView.tagIndexPath = indexPath
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WIATextFieldTableViewCell", for: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case WIAMakePlaceViewControllerSection.name.rawValue:
            return "Name of the place"
        case WIAMakePlaceViewControllerSection.address.rawValue:
            return "Address"
        case WIAMakePlaceViewControllerSection.coordinates.rawValue:
            return "Coordinates"
        case WIAMakePlaceViewControllerSection.phoneNumber.rawValue:
            return "Phone number (optional)"
        case WIAMakePlaceViewControllerSection.workingDays.rawValue:
            return "Working days (optional)"
        case WIAMakePlaceViewControllerSection.workinghours.rawValue:
            return "Working hours (optional)"
        default:
            return ""
        }
    }
    
    func tagsControl(_ tagsControl: TLTagsControl!, didUpdateTags tagArray: [String]!, with indexPath: IndexPath!) {
        
    }
    
    func tagsControlShouldBeginEditing(_ tagsControl: TLTagsControl!, with indexPath: IndexPath!) -> Bool {
        if indexPath.section == WIAMakePlaceViewControllerSection.phoneNumber.rawValue {
            return true
        }
        else{
            performSegue(withIdentifier: "WIAWorkingDaysTableViewControllerSegue", sender: self)
            return false
        }
    }
    
    func WIATextFieldTableViewCell(_ cell: WIATextFieldTableViewCell, shouldBeginEditingRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case WIAMakePlaceViewControllerSection.coordinates.rawValue:
            performSegue(withIdentifier: "WIAMapsViewControllerSegue", sender: self)
            return false
        default:
            return true
        }
    }
    
    func WIAWorkingDaysTableViewController(controller: WIAWorkingDaysTableViewController, didFinishWith workingDays: Array<Dictionary<String, Dictionary<String, Any>>>) {
        
    }
    
}
