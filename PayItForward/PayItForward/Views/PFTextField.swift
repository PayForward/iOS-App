//
//  PFTextField.swift
//  PayItForward
//
//  Created by Pankaj Khillon on 6/4/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

class PFTextField: UITextField, UITextFieldDelegate {

    override func draw(_ rect: CGRect) {
        let containerRect: CGRect = CGRect(x: 5, y: 0, width: 40, height: 50)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        // Original colors: 219, 237, 239
        // Changed for testing

        self.textColor = UIColor(red: 74, green: 74, blue: 74, alpha: 1.0)
        drawText(in: containerRect)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
