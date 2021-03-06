//
//  WIAReviewTableViewController.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 14/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit
import Photos

class WIAReviewTableViewController: UITableViewController, WIATextFieldTableViewCellDelegate, WIAChooseItemViewControllerDelegate, WIARatingTableViewCellDelegate, WIATextViewTableViewCellDelegate, WIAChoosePlaceViewControllerDelegate {

    enum WIAReviewViewControllerSection: Int {
        case image
        case item
        case place
        case rating
        case review
    }
    
    var selectedAssets : [PHAsset]!
    var itemObject : WIAItem!
    var placeObject : WIAPlace!
    var itemReview : String!
    var itemRating : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "WIACollectionViewTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIACollectionViewTableViewCell")
        tableView.register(UINib.init(nibName: "WIATextViewTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIATextViewTableViewCell")
        tableView.register(UINib.init(nibName: "WIATextFieldTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WIATextFieldTableViewCell")
        tableView.keyboardDismissMode = .interactive
        
        let saveButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(doneButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WIAChooseItemViewControllerSegue" {
            let nav : UINavigationController = segue.destination as! UINavigationController
            let controller : WIAChooseItemViewController = nav.viewControllers.first as! WIAChooseItemViewController
            controller.delegate = self
        }
        else if segue.identifier == "WIAChoosePlaceViewControllerSegue" {
            let nav : UINavigationController = segue.destination as! UINavigationController
            let controller : WIAChoosePlaceViewController = nav.viewControllers.first as! WIAChoosePlaceViewController
            controller.delegate = self
        }
    }
    
    func doneButtonClicked() {
        if selectedAssets == nil || selectedAssets.count == 0 {
            let alert = UIAlertController.init(title: "No Images Selected", message: "Please select at least one image", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else if itemObject == nil {
            let alert = UIAlertController.init(title: "Item missing?", message: "Please select an Item", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else if placeObject == nil && itemObject.place == nil {
            let alert = UIAlertController.init(title: "Place missing?", message: "Please select a place", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else if itemRating == nil || itemRating == 0.0 {
            let alert = UIAlertController.init(title: "Rating missing?", message: "Please Rate the Item", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else if itemReview == nil || itemReview.length == 0 {
            let alert = UIAlertController.init(title: "Review missing?", message: "Please specify what you feel about the Item", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else{
            tableView.endEditing(false)
            dismiss(animated: true, completion: { 
                if self.itemObject.place == nil {
                    self.itemObject.place = self.placeObject
                }
                WIAManager.saveItem(item: self.itemObject, rating: self.itemRating, review: self.itemReview, images: self.selectedAssets, completion: { (completed, item, error) in
                    
                })
            })
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
            cell.assets = selectedAssets
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
            let cell : WIATextViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WIATextViewTableViewCell", for: indexPath) as! WIATextViewTableViewCell
            cell.delegate = self
            cell.cellIndexPath = indexPath
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
    
    func WIATextFieldTableViewCellShouldBeginEditing(cell: WIATextFieldTableViewCell, indexPath: IndexPath) -> Bool {
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
    
    func WIAChooseItemViewController(controller: WIAChooseItemViewController, didFinishWith item: WIAItem) {
        let cell : WIATextFieldTableViewCell = tableView.cellForRow(at: IndexPath.init(row: 0, section: WIAReviewViewControllerSection.item.rawValue)) as! WIATextFieldTableViewCell
        itemObject = item
        cell.cellText = itemObject.name
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - WIAChoosePlaceViewControllerDelegate
    
    func WIAChoosePlaceViewController(controller: WIAChoosePlaceViewController, didFinishWith place: WIAPlace) {
        let cell : WIATextFieldTableViewCell = tableView.cellForRow(at: IndexPath.init(row: 0, section: WIAReviewViewControllerSection.place.rawValue)) as! WIATextFieldTableViewCell
        placeObject = place
        cell.cellText = placeObject.name
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - WIARatingTableViewCellDelegate
    
    func WIARatingTableViewCellDidChangeRating(cell: WIARatingTableViewCell, rating: Double, indexPath: IndexPath) {
        itemRating = rating
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - WIATextViewTableViewCellDelegate
    
    func WIATextViewCellDidChange(cell: WIATextViewTableViewCell, text: String, indexPath: IndexPath) {
        itemReview = text
    }
    
}
