//
//  HomeViewController.swift
//  PayItForward
//
//  Created by Pankaj Khillon on 4/16/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var postTableView: UITableView!
    
    
    @IBAction func launchCamera(_ sender: Any) {
    }

    @IBAction func launchMap(_ sender: Any) {
    }
    
    @IBAction func filterByRecent(_ sender: Any) {
    }
    
    @IBAction func filterByRequests(_ sender: Any) {
    }
    
    @IBAction func filterByOffers(_ sender: Any) {
    }
    
    @IBAction func viewAllFilters(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
