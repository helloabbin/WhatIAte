//
//  WIAMakeItemViewController.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 15/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

class WIAMakeItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, WIATextFieldTableViewCellDelegate {

    enum WIAMakeItemViewControllerSection: Int {
        case name = 0
        case price = 1
        case cuisine = 2
        case description = 3
    }
    
    var itemName : String?
    
    @IBOutlet weak var itemMakeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemMakeTableView.register(UINib.init(nibName: "WIATextFieldTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIATextFieldTableViewCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : WIATextFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIATextFieldTableViewCell", for: indexPath) as! WIATextFieldTableViewCell
        cell.delegate = self
        cell.cellIndexPath = indexPath
        cell.cellPlaceHolder = "type here"
        cell.cellText = itemName
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
