//
//  CreateAccountViewController.swift
//  PayItForward
//
//  Created by Jonathan Abercrombie on 5/7/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FacebookCore
import FacebookLogin

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var fbView: UIView!
    
    let fbManager = LoginManager(loginBehavior: .systemAccount, defaultAudience: .everyone)
    let loginButton = { () -> LoginButton in
        let button = LoginButton(readPermissions: [.email, .publicProfile, .userFriends])
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = LoginButton(readPermissions: [.email, .publicProfile, .userFriends])
        loginButton.center = fbView.center
        loginButton.delegate = self
        
        view.addSubview(loginButton)
        
        if let _ = AccessToken.current {
            print("signed in")
            //self.fetchProfile()
        }
        
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
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                print("user data below")
                print(user ?? "User data returned nil")
            }
            
            User.shared.email = email
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
    
    func loginButtonWillLogin(_ loginButton: LoginButton!) -> Bool {
        if let token = AccessToken.current {
            let credential = FacebookAuthProvider.credential(withAccessToken: token.authenticationToken)
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.performSegue(withIdentifier: "toVerify", sender: self)
            }
            return false
        }
        return true
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("completed login")
        switch result {
            case .success(grantedPermissions: let _, declinedPermissions: let _, token: let token):
                let credential = FacebookAuthProvider.credential(withAccessToken: token.authenticationToken)
                Auth.auth().signIn(with: credential) { (user, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    self.performSegue(withIdentifier: "toVerify", sender: self)
                }
        case .failed(let error):
            print(error.localizedDescription)
        case .cancelled:
            print("cancelled")
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("logged out user")
    }
}
