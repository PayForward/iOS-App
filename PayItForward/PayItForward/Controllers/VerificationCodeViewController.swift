//
//  VerificationCodeViewController.swift
//  PayItForward
//
//  Created by Jonathan Abercrombie on 5/7/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

class VerificationCodeViewController: UIViewController {

    @IBOutlet weak var verificationCodeField: UITextField!
    var verificationCode: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func next(_ sender: UIButton) {
        if verificationCodeIsValid() {
            performSegue(withIdentifier: "toName", sender: nil)
        }
        else {
            let warningVC = createWarningAlert(withTitle: "Your code does not match ours.", message: "Check to see if you entered it correctly.")
            self.present(warningVC, animated: true, completion: nil)
        }
    }
    
    func verificationCodeIsValid() -> Bool {
        // TODO: get verification code
        //return self.verificationCodeField.text == verificationCode
        
        return true
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
