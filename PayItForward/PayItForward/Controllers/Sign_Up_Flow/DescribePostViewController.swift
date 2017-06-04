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

    @IBOutlet weak var characterCountLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBAction func next(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionTextView.delegate = self
    }

}

extension DescribePostViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.characterCountLabel.text = "\(self.descriptionTextView.text.characters.count)/500"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = self.descriptionTextView.text as NSString
        
        let newText = currentText.replacingCharacters(in: range, with: text)
        
        let numChars = newText.characters.count
        
        return numChars <= 500
    }
}
