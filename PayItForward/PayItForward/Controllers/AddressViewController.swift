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
import GooglePlaces

class AddressViewController: UIViewController {
    
    var placesClient: GMSPlacesClient!
    
    @IBOutlet weak var addressField: PFTextField!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var currentLocButton: UIButton!
    
    var currentPlace: GMSPlace?
    
    var usedLocationFinder = false
    
    var sloZipCodes = ["93401", "93403", "93405", "93406", "93408", "93410"]
    var userZipCode: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placesClient = GMSPlacesClient.shared()
        
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
            self.currentLocButton.isEnabled = false
        }
        // TODO: add shadows
        
    }
    
    /// Phone finds user's location
    @IBAction func useCurrentLocation(_ sender: UIButton) {
        self.usedLocationFinder = true
        
        placesClient.currentPlace { (placeLikelihoodList, error) -> Void in
            if let err = error {
                print(err)
                self.displayErrorToUser()
            }
            
            if let plList = placeLikelihoodList {
                let place = plList.likelihoods.first?.place
                
                if let place = place {
                    self.currentPlace = place
                    
                    if let address = place.formattedAddress {
                        self.addressField.text = address
                        User.shared.address = address
                        
                        if self.zipCodeIsValid() {
                            self.performSegue(withIdentifier: "next", sender: nil)
                        }
                        else {
                            let warningVC = createWarningAlert(withTitle: "PayItForward is currently available only in San Luis Obispo", message: "Stay tuned as we expand!")
                            
                            self.present(warningVC, animated: true, completion: nil)
                        }
                    }
                    else {
                        self.displayErrorToUser()
                    }
                }
                else {
                    self.displayErrorToUser()
                }
            }
        }
    }
    
    func displayErrorToUser() {
        self.addressField.text = "Could not find your location."
    }

    // TODO: this doesn't work right either :/
    /// Checks if zip code is within SLO
    func zipCodeIsValid() -> Bool {
        var currentZip = ""
        
        if let components = self.currentPlace?.addressComponents {
            for field in components {
                if field.type == kGMSPlaceTypePostalCode {
                    currentZip = field.type
                }
            }
        }
        
        for zip in sloZipCodes {
            if currentZip == zip {
                return true
            }
        }
        
        return false
    }
    
    // TODO: THIS DOESN'T WORK YET :(
    /// User inputs their addresss
    func getLocation(from address: String) {
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            guard error != nil && (placemarks?.count)! > 0 else {
                print(error!)
                return
            }
            
            let placemark = (placemarks?.first)!
            self.userZipCode = placemark.postalCode!
            self.currentPlace = placemark.location!
        }
    }
}

extension AddressViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        self.present(autocompleteController, animated: true, completion: nil)
    }
}

extension AddressViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.currentPlace = place
        
        print(place)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
