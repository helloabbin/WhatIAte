//
//  WIAImagePickerController.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 12/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit

class WIAImagePickerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func launchCamera(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Camera", bundle: nil)
        let controller : CameraViewController = storyboard.instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
        controller.numberOfPhotosToTake = 3
        present(controller, animated: true, completion: nil)
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
