//
//  WIAReviewTableViewController.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 14/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit
import Photos

class WIAReviewTableViewController: UITableViewController, WIATextFieldTableViewCellDelegate, WIAChooseItemViewControllerDelegate, WIARatingTableViewCellDelegate {

    enum WIAReviewViewControllerSection: Int {
        case image = 0
        case item = 1
        case place = 2
        case rating = 3
        case review = 4
    }
    
    var selectedAssets : Array<PHAsset>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "WIACollectionViewTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIACollectionViewTableViewCell")
        tableView.register(UINib.init(nibName: "WIATextViewCellTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIATextViewCellTableViewCell")
        tableView.register(UINib.init(nibName: "WIATextFieldTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIATextFieldTableViewCell")
        tableView.keyboardDismissMode = .interactive
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WIAChooseItemViewControllerSegue" {
            let nav : UINavigationController = segue.destination as! UINavigationController
            let controller : WIAChooseItemViewController = nav.viewControllers.first as! WIAChooseItemViewController
            controller.delegate = self
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == WIAReviewViewControllerSection.image.rawValue{
            let cell : WIACollectionViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIACollectionViewTableViewCell", for: indexPath) as! WIACollectionViewTableViewCell
            cell.selectedAssets = selectedAssets!
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
            cell.delegate = self
            cell.cellIndexPath = indexPath
            return cell
        }
        else{
            let cell : WIATextViewCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIATextViewCellTableViewCell", for: indexPath) as! WIATextViewCellTableViewCell
            return cell
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UITableViewDelegate
    
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
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - WIATextFieldTableViewCellDelegate
    
    func WIATextFieldTableViewCellShouldBeginEditing(_ cell: WIATextFieldTableViewCell, with indexPath: IndexPath) -> Bool {
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
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - WIAChooseItemViewControllerDelegate
    
    func WIAChooseItemViewController(_ controller: WIAChooseItemViewController, didFinishWith item: WIAItem) {
        let cell : WIATextFieldTableViewCell = tableView.cellForRow(at: IndexPath.init(row: 0, section: WIAReviewViewControllerSection.item.rawValue)) as! WIATextFieldTableViewCell
        cell.cellText = item.itemName
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - WIARatingTableViewCellDelegate
    
    func WIARatingTableViewCellDidChangeRating(_ cell: WIARatingTableViewCell, rating: Double, with indexPath: IndexPath) {
        
    }
}
