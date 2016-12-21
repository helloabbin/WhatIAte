//
//  WIAChoosePlaceViewController.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 14/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

class WIAChoosePlaceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{

    var searchResult = [AnyObject]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - IBAction
    
    @IBAction func cancelPicker(_ sender: Any) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WIAPlaceViewControllerSegue" {
            let vc : WIAMakePlaceViewController = segue.destination as! WIAMakePlaceViewController
            vc.placeName = searchResult.first as! String?
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WIAChoosePlaceViewControllerCell", for: indexPath)
        
        let item = searchResult[indexPath.row]
        if  let obj = item as? String{
            cell.textLabel?.text = "Add '\(obj)' as a new Place"
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = searchResult[indexPath.row]
        if  item is String {
            performSegue(withIdentifier: "WIAPlaceViewControllerSegue", sender: self)
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        WIAManager.searchForPlace(searchText: searchText) { (results, searchedText) in
            if results.count > 0 {
                
            }
            else{
                searchResult .removeAll()
                searchResult.append(searchedText as AnyObject)
                searchTableView.reloadData()
            }
        }
        
    }

}
