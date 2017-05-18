//
//  CreateAccountViewController.swift
//  PayItForward
//
//  Created by Jonathan Abercrombie on 5/7/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func createAccountWithEmailAndPassword(_ sender: Any) {
        if emailIsValid() && passwordIsValid() {
            register(withEmail: self.emailField.text!, password: self.passwordField.text!)
        }
    }
    @IBAction func continueWithFB(_ sender: Any) {
        // TODO
    }
    
    func emailIsValid() -> Bool {
        // TODO
    }
    
    func passwordIsValid() -> Bool {
        // TODO
    }
    
    func register(withEmail email: String, password: String) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func next(_ sender: UIButton) {
        performSegue(withIdentifier: "toVerify", sender: nil)
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
