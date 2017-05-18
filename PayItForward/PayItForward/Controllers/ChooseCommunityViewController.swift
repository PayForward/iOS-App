//
//  ChooseCommunityViewController.swift
//  PayItForward
//
//  Created by Jonathan Abercrombie on 5/7/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

class ChooseCommunityViewController: UIViewController {

    @IBOutlet weak var slocalsAdmin: UIImageView!
    @IBOutlet weak var slocalsMembers: UILabel!
    
    @IBOutlet weak var calpolyAdmin: UIImageView!
    @IBOutlet weak var calpolyMembers: UILabel!

    let slocalsMembersCount = 23291
    let calpolyMembersCount = 23291
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slocalsMembers.text = "Public Group with \(slocalsMembersCount) Members"
        calpolyMembers.text = "Public Group with \(calpolyMembersCount) Members"
    }

    @IBAction func joinSlocals(_ sender: UIButton) {
        // TODO: Firebase add user to community
    }
    
    @IBAction func joinCalPoly(_ sender: UIButton) {
        // TODO: see above
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
