//
//  OfferChoicesViewController.swift
//  PayItForward
//
//  Created by Pankaj Khillon on 5/17/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit
import Firebase

class OfferChoicesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var ref: FIRDatabaseReference!
    var offerings = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        ref.child("offerings").observe(.value, with: { [weak self] snapshot in
            guard let strongSelf = self else { return }
            for child in snapshot.children {
                let childSnapshot = child as! FIRDataSnapshot
                let title = childSnapshot.value as! String
                strongSelf.offerings.append(title)
            }
            strongSelf.tableView.reloadData()
        })
    }
    
    deinit {
        ref.removeAllObservers()
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

extension OfferChoicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return offerings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "offering", for: indexPath)
        
        if let offering = cell as? OfferingTableViewCell {
            offering.title.text = offerings[indexPath.row]
        }
        
        return cell
    }
}
