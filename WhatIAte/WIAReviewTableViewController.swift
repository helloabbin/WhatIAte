//
//  WIAReviewTableViewController.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 14/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit
import Photos

class WIAReviewTableViewController: UITableViewController, WIATextFieldTableViewCellDelegate {

    enum WIAReviewViewControllerSection: Int {
        case image = 0
        case item = 1
        case place = 2
        case rating = 3
        case review = 4
    }
    
    public var selectedAssets = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "WIACollectionViewTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIACollectionViewTableViewCell")
        tableView.register(UINib.init(nibName: "WIATextViewCellTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIATextViewCellTableViewCell")
        tableView.register(UINib.init(nibName: "WIATextFieldTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIATextFieldTableViewCell")
        tableView.keyboardDismissMode = .interactive
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == WIAReviewViewControllerSection.image.rawValue{
            let cell : WIACollectionViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIACollectionViewTableViewCell", for: indexPath) as! WIACollectionViewTableViewCell
            cell.selectedAssets = selectedAssets
            return cell
        }
        else if indexPath.section == WIAReviewViewControllerSection.item.rawValue{
            let cell : WIATextFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIATextFieldTableViewCell", for: indexPath) as! WIATextFieldTableViewCell
            cell.delegate = self
            cell.cellIndexPath = indexPath
            cell.cellPlaceHolder = "add an Item"
            return cell
        }
        else if indexPath.section == WIAReviewViewControllerSection.place.rawValue {
            let cell : WIATextFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIATextFieldTableViewCell", for: indexPath) as! WIATextFieldTableViewCell
            cell.delegate = self
            cell.cellIndexPath = indexPath
            cell.cellPlaceHolder = "add a Place"
            return cell
        }
        else if indexPath.section == WIAReviewViewControllerSection.rating.rawValue {
            let cell : WIARatingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIARatingTableViewCell", for: indexPath) as! WIARatingTableViewCell
            return cell
        }
        else{
            let cell : WIATextViewCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIATextViewCellTableViewCell", for: indexPath) as! WIATextViewCellTableViewCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case WIAReviewViewControllerSection.image.rawValue:
            return 100
        case WIAReviewViewControllerSection.item.rawValue:
            return 44
        case WIAReviewViewControllerSection.place.rawValue:
            return 44
        case WIAReviewViewControllerSection.rating.rawValue:
            return 44
        case WIAReviewViewControllerSection.review.rawValue:
            return 100
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case WIAReviewViewControllerSection.image.rawValue:
            return "Images"
        case WIAReviewViewControllerSection.item.rawValue:
            return "Item"
        case WIAReviewViewControllerSection.place.rawValue:
            return "Place Where you can get this"
        case WIAReviewViewControllerSection.rating.rawValue:
            return "How Much Do You Rate This"
        case WIAReviewViewControllerSection.review.rawValue:
            return "Say Something nice"
        default:
            return ""
        }
    }
    
    func WIATextFieldTableViewCell(_ cell: WIATextFieldTableViewCell, shouldBeginEditingRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case WIAReviewViewControllerSection.item.rawValue:
            performSegue(withIdentifier: "WIAChooseItemViewControllerSegue", sender: self)
            return false
        case WIAReviewViewControllerSection.place.rawValue:
            performSegue(withIdentifier: "WIAChoosePlaceViewControllerSegue", sender: self)
            return false
        default:
            return true
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
}
