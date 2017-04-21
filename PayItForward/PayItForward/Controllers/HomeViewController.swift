//
//  HomeViewController.swift
//  PayItForward
//
//  Created by Pankaj Khillon on 4/16/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit
//import Firebase

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var postTableView: UITableView!
    
    var posts = [Post]()
    
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

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath)
        
        if let postCell = cell as? PostTableViewCell {
            let post = posts[indexPath.row]
            postCell.titleLabel.text = post.title
            postCell.detailLabel.text = post.description
            
            if post.price == 0 {
                postCell.priceLabel.text = "Free"
//                postCell.priceView.backgroundColor = 
            } else if post.type == .request {
                postCell.priceLabel.text = "Redeem"
                postCell.price.text = String(post.price)
//                postCell.priceView.backgroundColor = 
            } else {
                postCell.priceLabel.text = "Offer"
                postCell.price.text = String(post.price)
//                postCell.priceView.backgroundColor = 
            }
            
            postCell.userImage.image = post.image
        }
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {}






