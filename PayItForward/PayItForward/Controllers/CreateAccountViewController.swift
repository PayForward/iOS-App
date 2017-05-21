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
    
    let fbManager = LoginManager(loginBehavior: .systemAccount, defaultAudience: .everyone)
    let loginButton = { () -> LoginButton in 
        let button = LoginButton(readPermissions: [.email, .publicProfile])
        return button
    }
    
    
    @IBAction func createAccountWithEmailAndPassword(_ sender: Any) {
        if emailIsValid() {
            if passwordIsValid() {
                register(withEmail: self.emailField.text!, password: self.passwordField.text!)
            }
            else {
                let warningVC = createWarningAlert(withTitle: "Uh oh!", message: "The password field is invalid")
                self.present(warningVC, animated: true, completion: nil)
            }
        }
        else {
            let warningVC = createWarningAlert(withTitle: "Uh oh!", message: "The email field is invalid")
            self.present(warningVC, animated: true, completion: nil)
        }
    }
    
    func emailIsValid() -> Bool {
        // trim whitespace
        let emailText = self.emailField.text!.trimmingCharacters(in: .whitespaces)
        
        let pattern = "\\w+.\\w+@\\w+.\\w+.\\w+"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: emailText, options: [], range: NSRange(location: 0, length: emailText.characters.count))
        
        self.emailField.text = emailText
        
        return matches.count > 0
    }
    
    func passwordIsValid() -> Bool {
        // trim whitespace
        self.passwordField.text = self.passwordField.text!.trimmingCharacters(in: .whitespaces)
        
        let minRequiredCharCount = 8
        
        return self.passwordField.text!.characters.count > minRequiredCharCount
    }
    
    func register(withEmail email: String, password: String) {
        print("registering")
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error)
            }
            else {
                print("user data below")
                print(user)
            }
            
            self.performSegue(withIdentifier: "toVerify", sender: self)
        }
    }
    
    func fetchProfile(with token: AccessToken) {
//        print("fetching profile")
//        
//        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
//        GraphRequest(graphPath: "me", parameters: parameters, accessToken: token, httpMethod: .GET, apiVersion: .defaultVersion) { (connection, result, error) -> Void in
//        
//            if error != nil {
//                print(error)
//                return
//            }
//            
//            i
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(self.loginButton())
        
        if let token = AccessToken.current {
            //self.fetchProfile()
        }
        
        // pad text view
        let padding = 5
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 50))
        
        self.emailField.leftView = paddingView
        self.passwordField.leftView = paddingView
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

extension CreateAccountViewController: LoginButtonDelegate {
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("completed login")
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("logged out user")
    }
}
