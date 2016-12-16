//
//  WIAChooseItemViewController.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 14/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit
import CloudKit

protocol WIAChooseItemViewControllerDelegate {
    
    func WIAChooseItemViewController(_ controller: WIAChooseItemViewController, didFinishPickingItem item: CKRecord)
    
}

class WIAChooseItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var delegate: WIAChooseItemViewControllerDelegate?
    var searchResult = [AnyObject]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    @IBAction func cancelPicker(_ sender: Any) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WIAMakeItemViewControllerSegue" {
            let vc : WIAMakeItemViewController = segue.destination as! WIAMakeItemViewController
            vc.itemName = searchResult.first as! String?
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WIAChooseItemViewControllerCell", for: indexPath)
        
        let item = searchResult[indexPath.row]
        if  let obj = item as? String{
            cell.textLabel?.text = "Add '\(obj)' as a new Item"
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = searchResult[indexPath.row]
        if  item is String {
            performSegue(withIdentifier: "WIAMakeItemViewControllerSegue", sender: self)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        WIAManager.searchForItemWith(input: searchText, completion: { (result: [CKRecord], searchedText: String) in
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
