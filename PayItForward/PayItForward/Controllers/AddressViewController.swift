//
//  AddressViewController.swift
//  PayItForward
//
//  Created by Jonathan Abercrombie on 5/7/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController {

    @IBOutlet weak var addressField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: add shadows
    }

    @IBAction func useCurrentLocation(_ sender: UIButton) {
        
    }
    
    @IBAction func next(_ sender: UIButton) {
        performSegue(withIdentifier: "next", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
