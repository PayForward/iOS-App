//
//  DescribePostViewController.swift
//  PayItForward
//
//  Created by Pankaj Khillon on 5/26/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

class DescribePostViewController: UIViewController {
    
    var post: Post!

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBAction func next(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
