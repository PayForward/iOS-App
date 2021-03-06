//
//  TermsOfServiceViewController.swift
//  PayItForward
//
//  Created by Jonathan Abercrombie on 5/7/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

class TermsOfServiceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doNotAccept(_ sender: UIButton) {
        let warningVC = createWarningAlert(withTitle: "Are you sure?", message: "You must accept the terms and conditions to use PayItForward. If you still do not accept, please uninstall the app.")
        
        self.present(warningVC, animated: true, completion: nil)
    }
    
    @IBAction func accept(_ sender: UIButton) {
        performSegue(withIdentifier: "toCreateAccount", sender: nil)
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
