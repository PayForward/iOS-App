//
//  AddressViewController.swift
//  PayItForward
//
//  Created by Jonathan Abercrombie on 5/7/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseDatabase

class AddressViewController: UIViewController {
    
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var currentLocButton: UIButton!
    var locationManager:CLLocationManager?
    var currentLocation:CLLocation?
    var usedLocationFinder = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        
        if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
            self.currentLocButton.isEnabled = false
        }
        // TODO: add shadows
        
    }
    
    @IBAction func useCurrentLocation(_ sender: UIButton) {
        CLGeocoder().reverseGeocodeLocation(self.currentLocation!) { (placemarks, error) in
            if error != nil && (placemarks?.count)! > 0 {
                print(error!)
                return
            }
            
            let placemark = (placemarks?.first)!
            self.addressField.text = placemark.name ?? "\(self.currentLocation!.coordinate.latitude), \(self.currentLocation!.coordinate.longitude)"
            self.usedLocationFinder = true
            print("reverse location: \(self.addressField.text!)")
        }
        
    }
    
    @IBAction func next(_ sender: UIButton) {
        guard self.addressField.text != "" else {
            print("address field blank")
            return
        }
        
        if !usedLocationFinder {
            self.getLocation(from: self.addressField.text!)
        }
        
        self.save(self.currentLocation!)
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    func getLocation(from address: String) {
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            guard error != nil && (placemarks?.count)! > 0 else {
                print(error!)
                return
            }
            
            let placemark = (placemarks?.first)!
            self.currentLocation = placemark.location!
            print(self.currentLocation)
        }
    }
    
    func save(_ userLoc: CLLocation) {
        print("saved")
        //        let userRef = FIRDatabase.database().reference(withPath: "user")
        //        let lat = userLoc.coordinate.latitude
        //        let long = userLoc.coordinate.longitude
        //
        //        userRef.child("location").child("longitude").setValue(long)
        //        userRef.child("location").child("latitude").setValue(lat)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension AddressViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
