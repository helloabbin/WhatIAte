//
//  WIACuisineViewController.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 20/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

protocol WIACuisineViewControllerDelegate {
    
    func WIACuisineViewController(_ controller: WIACuisineViewController, didFinishPickingItem cuisine: WIACuisine)
    
}

class WIACuisineViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var delegate: WIACuisineViewControllerDelegate?
    var searchResult = [AnyObject]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - IBAction
    
    @IBAction func cancelPicker(_ sender: Any) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WIACuisineViewControllerCell", for: indexPath)
        
        let item = searchResult[indexPath.row]
        if  let obj = item as? String{
            cell.textLabel?.text = "Add '\(obj)' as a new Cuisine"
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: {
            
            if let delegate = self.delegate {
                let item = self.searchResult[indexPath.row]
                if  item is String {
                    let cuisine = WIACuisine()
                    cuisine.cuisineName = item as! String
                    delegate.WIACuisineViewController(self, didFinishPickingItem: cuisine)
                }
                else{
                    let cuisine : WIACuisine = self.searchResult[indexPath.row] as! WIACuisine
                    delegate.WIACuisineViewController(self, didFinishPickingItem: cuisine)
                }
            }
        })
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        WIAManager.searchForCuisineWith(input: searchText, completion: { (result: [WIACuisine], searchedText: String) in
            if result.count > 0 {
                
            }
            else{
                searchResult .removeAll()
                searchResult.append(searchedText as AnyObject)
                searchResultTableView.reloadData()
            }
        })
        
    }

}
