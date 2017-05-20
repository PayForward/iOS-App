//
//  VerifyNewMemberViewController.swift
//  PayItForward
//
//  Created by Jonathan Abercrombie on 5/7/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

class VerifyNewMemberViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberField: UITextField!
    var verificationCode: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func next(_ sender: UIButton) {
        if phoneNumberIsValid() {
            // launch twilio text messaging verification
            print("valid phone number")
        }
        else {
            let alertController = UIAlertController(title: "Invalid phone number", message: "Your phone number must have 10 digits.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        performSegue(withIdentifier: "toVerificationCode", sender: nil)
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let newVC = segue.destination as! VerificationCodeViewController
        newVC.verificationCode = self.verificationCode
    }
    

}
