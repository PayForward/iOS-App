//
//  SetLocationViewController.swift
//  PayItForward
//
//  Created by Pankaj Khillon on 5/17/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

class SetLocationViewController: UIViewController {

    
    @IBOutlet weak var locationTextField: UITextField!
    var shareChoice: AddressShareChoice!
    
    @IBAction func shareSpecificAddress(_ sender: Any) {
        self.shareChoice = AddressShareChoice.Specific
    }
    
    @IBAction func shareGeneralVicinity(_ sender: Any) {
        self.shareChoice = AddressShareChoice.General
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationTextField.text = User.shared.address
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
        let travelChoiceVC = segue.destination as! TravelChoiceViewController
        travelChoiceVC.shareChoice = self.shareChoice
    }
 

}
