//
//  WIAMakePlaceViewController.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 16/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit
import CoreLocation

class WIAMakePlaceViewController: UITableViewController, WIATextFieldTableViewCellDelegate, TLTagsControlDelegate, WIAWorkingDaysTableViewControllerDelegate, WIAMapsViewControllerDelegate {
    
    enum WIAMakePlaceViewControllerSection: Int {
        case name
        case address
        case coordinates
        case phoneNumber
        case workingDays
        case workinghours
    }
    
    var delegate: WIAChoosePlaceViewControllerDelegate!
    
    var placeName : String!
    var placeAddress : String!
    var placeCoordinates : CLLocation!
    
    var placePhoneNumbers : [String]?
    var placeWorkingDays : [[String : [String : Any]]]?
    var placeWokingFrom : String?
    var placeWorkingTill : String?
    
    let fromDatePicker = UIDatePicker()
    let tillDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromDatePicker.backgroundColor = UIColor.white
        fromDatePicker.datePickerMode = .time
        fromDatePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        tillDatePicker.backgroundColor = UIColor.white
        tillDatePicker.datePickerMode = .time
        tillDatePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        tableView.keyboardDismissMode = .interactive
        tableView.register(UINib.init(nibName: "WIAWorkingHoursTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIAWorkingHoursTableViewCell")
        tableView.register(UINib.init(nibName: "WIATextFieldTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIATextFieldTableViewCell")
        tableView.register(UINib.init(nibName: "WIATagTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIATagTableViewCell")
        
        let saveButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WIAWorkingDaysTableViewControllerSegue" {
            let nav : UINavigationController = segue.destination as! UINavigationController
            let controller : WIAWorkingDaysTableViewController = nav.viewControllers.first as! WIAWorkingDaysTableViewController
            controller.delegate = self
            controller.workingDaysArray = placeWorkingDays
        }
        else if segue.identifier == "WIAMapsViewControllerSegue"{
            let nav : UINavigationController = segue.destination as! UINavigationController
            let controller : WIAMapsViewController = nav.viewControllers.first as! WIAMapsViewController
            controller.delegate = self
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - IBAction
    
    func doneButtonClicked() {
        if placeName == nil || placeName.length == 0 {
            let alert = UIAlertController.init(title: "Name missing?", message: "Please enter Name of the Place", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else if placeAddress == nil || placeAddress.length == 0 {
            let alert = UIAlertController.init(title: "Address missing?", message: "Please enter Address of the Place", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else if placeCoordinates == nil {
            let alert = UIAlertController.init(title: "Coordinates missing?", message: "Please enter Coordinates of the Place", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else if (placeWorkingDays != nil && (placeWorkingDays?.count)! > 0) && (placeWokingFrom == nil || placeWorkingTill == nil) {
            let alert = UIAlertController.init(title: "Time missing?", message: "Please enter From and Till time", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else if placeWorkingDays == nil && (placeWokingFrom != nil || placeWorkingTill != nil) {
            let alert = UIAlertController.init(title: "Working days missing?", message: "Please enter the working days of this Place", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else{
            tableView.endEditing(false)
            dismiss(animated: true, completion: {
                let place = WIAPlace(name: self.placeName, address: self.placeAddress, location: self.placeCoordinates, phoneNumbers: self.placePhoneNumbers)
                let controller : WIAChoosePlaceViewController = self.navigationController!.viewControllers.first as! WIAChoosePlaceViewController
                self.delegate.WIAChoosePlaceViewController(controller: controller, didFinishWith: place)
            })
        }
    }
    
    func datePickerValueChanged(_ sender: UIDatePicker){
        let cell : WIAWorkingHoursTableViewCell = tableView.cellForRow(at: IndexPath(row: 0, section: WIAMakePlaceViewControllerSection.workinghours.rawValue)) as! WIAWorkingHoursTableViewCell
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        if sender === fromDatePicker {
            let from = formatter.string(from: sender.date)
            cell.fromText = from
            placeWokingFrom = from
        }
        else {
            let till = formatter.string(from: sender.date)
            cell.tillText = till
            placeWorkingTill = till
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UITableViewDataSource

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
            cell.tagView.tagsBackgroundColor = WIAColor.mainColor
            return cell
        }
        else if indexPath.section == WIAMakePlaceViewControllerSection.workingDays.rawValue {
            let cell : WIATagTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIATagTableViewCell", for: indexPath) as! WIATagTableViewCell
            cell.tagView.tapDelegate = self
            cell.tagView.tagsBackgroundColor = WIAColor.mainColor
            cell.tagView.tagIndexPath = indexPath
            cell.cellPlaceHolder = "tap here"
            return cell
        }
        else {
            let cell: WIAWorkingHoursTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIAWorkingHoursTableViewCell", for: indexPath) as! WIAWorkingHoursTableViewCell
            cell.fromInputView = fromDatePicker
            cell.tillInputView = tillDatePicker
            return cell
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UITableViewDelegate
    
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == WIAMakePlaceViewControllerSection.workinghours.rawValue {
            return 112
        }
        else{
            return 44
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - TLTagsControlDelegate
    
    func tagsControl(_ tagsControl: TLTagsControl!, didUpdateTags tagArray: [String]!, with indexPath: IndexPath!) {
        if indexPath.section == WIAMakePlaceViewControllerSection.phoneNumber.rawValue {
            placePhoneNumbers = tagArray
        }
    }
    
    func tagsControl(_ tagsControl: TLTagsControl!, didDeleteTags tagIndex: Int, with indexPath: IndexPath!) {
        if indexPath.section == WIAMakePlaceViewControllerSection.workingDays.rawValue {
            placeWorkingDays?.remove(at: tagIndex)
        }
        if tagsControl.tags.count > 0 {
            tagsControl.tagPlaceholder = ""
        }
        else{
            tagsControl.tagPlaceholder = "tap here"
        }
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
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - WIATextFieldTableViewCellDelegate
    
    func WIATextFieldTableViewCellDidChangeEditing(cell: WIATextFieldTableViewCell, indexPath: IndexPath) {
        switch indexPath.section {
        case WIAMakePlaceViewControllerSection.name.rawValue:
            placeName = cell.cellText
        case WIAMakePlaceViewControllerSection.address.rawValue:
            placeAddress = cell.cellText
        default:
            break
        }
    }
    
    func WIATextFieldTableViewCellShouldBeginEditing(cell: WIATextFieldTableViewCell, indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case WIAMakePlaceViewControllerSection.coordinates.rawValue:
            performSegue(withIdentifier: "WIAMapsViewControllerSegue", sender: self)
            return false
        default:
            return true
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - WIAWorkingDaysTableViewControllerDelegate
    
    func WIAWorkingDaysTableViewController(controller: WIAWorkingDaysTableViewController, didFinishWith workingDays: [[String : [String : Any]]]) {
        let cell : WIATagTableViewCell = tableView.cellForRow(at: IndexPath(row: 0, section: WIAMakePlaceViewControllerSection.workingDays.rawValue)) as! WIATagTableViewCell
        cell.tagView.tags.removeAllObjects()
        
        placeWorkingDays = workingDays
        
        for dict in placeWorkingDays! {
            let openDict = dict["open"]
            let dayName = openDict?["dayName"]
            cell.tagView.tags.add(dayName!)
        }
        if cell.tagView.tags.count > 0 {
            cell.cellPlaceHolder = ""
        }
        else{
            cell.cellPlaceHolder = "tap here"
        }
        cell.tagView.reloadTagSubviews()
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - WIAMapsViewControllerDelegate
    
    func WIAMapsViewController(controller: WIAMapsViewController, didFinishWith location: CLLocation) {
        placeCoordinates = location
        let cell : WIATextFieldTableViewCell = tableView.cellForRow(at: IndexPath(row: 0, section: WIAMakePlaceViewControllerSection.coordinates.rawValue)) as! WIATextFieldTableViewCell
        cell.cellText = "\(placeCoordinates.coordinate.latitude), \(placeCoordinates.coordinate.longitude)"
    }
    
}
