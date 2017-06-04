//
//  PFTextView.swift
//  PayItForward
//
//  Created by Pankaj Khillon on 6/4/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

class PFTextView: UITextView, UITextViewDelegate {
    
    public var shouldLimitCharacters = true
    public var characterLimit = 500
    public var padding: CGFloat = 5

    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor(red: 219, green: 237, blue: 239, alpha: 1.0)
        self.textColor = UIColor(red: 74, green: 74, blue: 74, alpha: 1.0)
        self.textContainerInset = UIEdgeInsetsMake(padding * 2, padding, padding * 2, padding)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if shouldLimitCharacters {
            let currentText = self.text as NSString
            let newText = currentText.replacingCharacters(in: range, with: text)
            let numChars = newText.characters.count
            
            return numChars <= characterLimit
        }
        else {
            return true
        }
    }
}
