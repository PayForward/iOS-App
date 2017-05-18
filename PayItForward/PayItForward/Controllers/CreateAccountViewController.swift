//
//  CreateAccountViewController.swift
//  PayItForward
//
//  Created by Jonathan Abercrombie on 5/7/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit
import FirebaseAuth
import FacebookCore
import FacebookLogin

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func createAccountWithEmailAndPassword(_ sender: Any) {
        if emailIsValid() && passwordIsValid() {
            register(withEmail: self.emailField.text!, password: self.passwordField.text!)
        }
    }
    
    func emailIsValid() -> Bool {
        // TODO
    }
    
    func passwordIsValid() -> Bool {
        // TODO
    }
    
    func register(withEmail email: String, password: String) {
        
    }
    
    func loginWithFB() {
        let loginManager = LoginManager()
            
        loginManager.logIn([.email, .publicProfile], viewController: self, completion: { (LoginResult) in
            switch LoginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login")
            case .success(grantedPermissions: let grantedPermissions, declinedPermissions: let declinedPermissions, token: let accessToken):
                print("Logged in")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fbLoginButton = UIButton(type: .custom)
        fbLoginButton.setBackgroundImage(#imageLiteral(resourceName: "ContinueWithFacebook"), for: .normal)
        fbLoginButton.frame = CGRect(x: 16, y: 168, width: 343, height: 50)
        
        fbLoginButton.addTarget(self, action: #selector(self.loginWithFB), for: .touchUpInside)
        view.addSubview(fbLoginButton)
        
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
