//
//  WIAWorkingDaysTableViewController.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 16/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

protocol WIAWorkingDaysTableViewControllerDelegate {
    
    func WIAWorkingDaysTableViewController(controller: WIAWorkingDaysTableViewController, didFinishWith workingDays: [[String : [String : Any]]])
    
}

class WIAWorkingDaysTableViewController: UITableViewController, WIAWorkingDaysTableViewCellDelegate {
    
    enum WIAWorkingDaysTableViewControllerRow: Int {
        case sunday
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
    }
    
    var workingDaysArray: [[String : [String : Any]]]?
    var daysArray = [Int]()
    
    var delegate: WIAWorkingDaysTableViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let saveButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
        
        let cacnel = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(cancelButtonClicked))
        navigationItem.leftBarButtonItem = cacnel
        
        for dict in workingDaysArray ?? [] {
            let day = dict["close"]? ["day"]
            daysArray.append(day as! Int)
        }
        print(daysArray)
    }
    
    func cancelButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    func doneButtonClicked() {
        var arrayOfDays = [[String : [String : Any]]]()
        for num in daysArray {
            
            let dateFormater = DateFormatter()
            let daySymbols = dateFormater.standaloneWeekdaySymbols
            
            let dayName = daySymbols?[num]
            
            let close = ["day":num, "dayName":dayName!] as [String : Any]
            let open = ["day":num, "dayName":dayName!] as [String : Any]
            let mainDict = ["close":close, "open":open]
            
            arrayOfDays.append(mainDict)
            
        }
        dismiss(animated: true, completion: {
            if let delegate = self.delegate {
                delegate.WIAWorkingDaysTableViewController(controller: self, didFinishWith: arrayOfDays)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : WIAWorkingDaysTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIAWorkingDaysTableViewCell", for: indexPath) as! WIAWorkingDaysTableViewCell
        
        switch indexPath.row {
        case WIAWorkingDaysTableViewControllerRow.sunday.rawValue:
            cell.cellText = "Sunday"
        case WIAWorkingDaysTableViewControllerRow.monday.rawValue:
            cell.cellText = "Monday"
        case WIAWorkingDaysTableViewControllerRow.tuesday.rawValue:
            cell.cellText = "Tuesday"
        case WIAWorkingDaysTableViewControllerRow.wednesday.rawValue:
            cell.cellText = "Wednesday"
        case WIAWorkingDaysTableViewControllerRow.thursday.rawValue:
            cell.cellText = "Thursday"
        case WIAWorkingDaysTableViewControllerRow.friday.rawValue:
            cell.cellText = "Friday"
        case WIAWorkingDaysTableViewControllerRow.saturday.rawValue:
            cell.cellText = "Saturday"
        default: break
        }
        
        cell.cellIndexPath = indexPath
        cell.delegate = self
        
        if daysArray.contains(indexPath.row) {
            cell.isOn = true
        }
        else{
            cell.isOn = false
        }
        
        return cell
    }
    
    func WIAWorkingDaysTableViewCellDidChangeStatus(cell: WIAWorkingDaysTableViewCell, status: Bool, indexPath: IndexPath) {
        if status {
            daysArray.append(indexPath.row)
        }
        else {
            daysArray.remove(at: daysArray.index(of: indexPath.row)!)
        }
    }
    
}
