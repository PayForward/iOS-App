//
//  NameViewController.swift
//  PayItForward
//
//  Created by Jonathan Abercrombie on 5/7/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func next(_ sender: UIButton) {
        if namesAreValid() {
            User.shared.firstName = self.firstNameField.text!
            User.shared.lastName = self.lastNameField.text!
            
            performSegue(withIdentifier: "toAbout", sender: nil)
        }
        else {
            let warningVC = createWarningAlert(withTitle: "Names cannot be empty", message: "One or more of the name fields are empty.")
            self.present(warningVC, animated: true, completion: nil)
        }
    }
    
    func namesAreValid() -> Bool {
        self.firstNameField.text = self.firstNameField.text?.trimmingCharacters(in: .whitespaces)
        self.lastNameField.text = self.lastNameField.text?.trimmingCharacters(in: .whitespaces)
        
        let fNameCount = self.firstNameField.text?.characters.count ?? 0
        let lNameCount = self.lastNameField.text?.characters.count ?? 0
        
        return fNameCount > 0 && lNameCount > 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
