//
//  WIAWorkingDaysTableViewController.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 16/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

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
    
    var workingDaysArray = [[String:[String:Int]]]()
    private var daysArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let saveButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
        
        let cacnel = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(cancelButtonClicked))
        navigationItem.leftBarButtonItem = cacnel
        
        for dict in workingDaysArray {
            let day = dict["close"]? ["day"]
            daysArray.append(day!)
        }
    }
    
    func cancelButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    func doneButtonClicked() {
        var arrayOfDays = [[String:[String : Any]]]()
        for num in daysArray {
            
            let dateFormater = DateFormatter()
            let daySymbols = dateFormater.standaloneWeekdaySymbols
            
            let dayName = daySymbols?[num]
            
            let close = ["day":num, "dayName":dayName!] as [String : Any]
            let open = ["day":num, "dayName":dayName!] as [String : Any]
            let mainDict = ["close":close, "open":open]
            
            arrayOfDays.append(mainDict)
            
        }
        dismiss(animated: true, completion: nil)
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
        
        return cell
    }
    
    func WIAWorkingDaysTableViewCell(cell: WIAWorkingDaysTableViewCell, didChange status: Bool, at indexPath: IndexPath) {
        if status {
            daysArray.append(indexPath.row)
        }
        else {
            daysArray.remove(at: indexPath.row)
        }
    }
    
}
