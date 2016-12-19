//
//  WIAMapsViewController.swift
//  WhatIAte
//
//  Created by Abbin Varghese on 19/12/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit
import GoogleMaps

class WIAMapsViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    var didFinishFirstLocationUpdate = false
    var currentLocation : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse || status == .notDetermined {
            locationManager.delegate = self;
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        else{
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelMap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func doneWithMap(_ sender: Any) {
        dismiss(animated: true, completion: {
            
        })
    }
    
    @IBAction func goToCurrentLocation(_ sender: Any) {
        let camera = GMSCameraPosition.camera(withLatitude: (currentLocation!.coordinate.latitude), longitude: (currentLocation!.coordinate.longitude), zoom: 15.0)
        mapView.animate(to: camera)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if didFinishFirstLocationUpdate == false {
            currentLocation = locations.last
            let camera = GMSCameraPosition.camera(withLatitude: (currentLocation!.coordinate.latitude), longitude: (currentLocation!.coordinate.longitude), zoom: 15.0)
            mapView.animate(to: camera)
            didFinishFirstLocationUpdate = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
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
