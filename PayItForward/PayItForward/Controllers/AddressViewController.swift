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
    
    var sloZipCodes = ["93401", "93403", "93405", "93406", "93408", "93410"]
    var userZipCode: String!
    
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
    
    /// Phone finds user's location
    @IBAction func useCurrentLocation(_ sender: UIButton) {
        CLGeocoder().reverseGeocodeLocation(self.currentLocation!) { (placemarks, error) in
            if error != nil && (placemarks?.count)! > 0 {
                print(error!)
                return
            }
            
            let placemark = (placemarks?.first)!
            self.userZipCode = placemark.postalCode!
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
        
        User.shared.address = self.addressField.text!
        
        if zipCodeIsValid() {
            performSegue(withIdentifier: "next", sender: nil)
        }
        else {
            let warningVC = createWarningAlert(withTitle: "PayItForward is currently available only in San Luis Obispo", message: "Stay tuned as we expand!")
            
            self.present(warningVC, animated: true, completion: nil)
        }
    }
    
    // ERROR: this doesn't work right either :/
    /// Checks if zip code is within SLO
    func zipCodeIsValid() -> Bool {
//        for zip in sloZipCodes {
//            if userZipCode == zip {
//                return true
//            }
//        }
        
        return true
    }
    
    // ERROR: THIS DOESN'T WORK YET.
    /// User inputs their addresss
    func getLocation(from address: String) {
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            guard error != nil && (placemarks?.count)! > 0 else {
                print(error!)
                return
            }
            
            let placemark = (placemarks?.first)!
            self.userZipCode = placemark.postalCode!
            self.currentLocation = placemark.location!
        }
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
