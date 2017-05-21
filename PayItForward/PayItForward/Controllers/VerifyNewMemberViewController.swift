//
//  VerifyNewMemberViewController.swift
//  PayItForward
//
//  Created by Jonathan Abercrombie on 5/7/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit
import FirebaseDatabase

class VerifyNewMemberViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func next(_ sender: UIButton) {
        if phoneNumberIsValid() {
            // TODO: launch text messaging verification
            
            User.shared.phoneNum = self.phoneNumberField.text!
            print("valid phone number")
            
            if isNewUser() {
                performSegue(withIdentifier: "toVerificationCode", sender: nil)
            }
            else {
                let alertVC = UIAlertController(title: "You already have an account!", message: "Use your existing account to log in.", preferredStyle: .alert)
                
                let forgotPassword = UIAlertAction(title: "Forgot Password", style: .default) { (action) in
                    // TODO: add Forgot password
                }
                let login = UIAlertAction(title: "Log In", style: .default) { (action) in
                    self.performSegue(withIdentifier: "loginVC", sender: self)
                }
                
                alertVC.addAction(forgotPassword)
                alertVC.addAction(login)
                
                self.present(alertVC, animated: true, completion: nil)
            }
            
        }
        else {
            let warningVC = createWarningAlert(withTitle: "Invalid phone number", message: "Your phone number must have 10 digits.")
            
            self.present(warningVC, animated: true, completion: nil)
        }
    }
    
    func isNewUser() -> Bool {
        // TODO: perform search by phone number in firebase to find if new user
        
        return true
    }
    
    func phoneNumberIsValid() -> Bool {
        // trim whitespace
        let phoneNumber = self.phoneNumberField.text!.trimmingCharacters(in: .whitespaces)
        
        let pattern = "[0-9]"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: phoneNumber, options: [], range: NSRange(location: 0, length: phoneNumber.characters.count))
        
        self.phoneNumberField.text = phoneNumber
        
        return matches.count == 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
