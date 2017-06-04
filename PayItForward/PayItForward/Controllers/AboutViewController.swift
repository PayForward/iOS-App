//
//  AboutViewController.swift
//  PayItForward
//
//  Created by Jonathan Abercrombie on 5/7/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var aboutTextView: UITextView!
    
    @IBOutlet weak var characterCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.aboutTextView.delegate = self
        
    }

    @IBAction func next(_ sender: UIButton) {
        User.shared.bio = self.aboutTextView.text
        performSegue(withIdentifier: "toPhoto", sender: nil)
    }

}

extension AboutViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.characterCountLabel.text = "\(self.aboutTextView.text.characters.count)/500"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = self.aboutTextView.text as NSString
        
        let newText = currentText.replacingCharacters(in: range, with: text)
        
        let numChars = newText.characters.count
        
        return numChars <= 500
    }
}
