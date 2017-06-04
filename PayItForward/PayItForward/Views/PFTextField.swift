//
//  PFTextField.swift
//  PayItForward
//
//  Created by Pankaj Khillon on 6/4/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

class PFTextField: UITextField {

    override func draw(_ rect: CGRect) {
        drawText(in: CGRect(5, 0, 40, 50))
        self.backgroundColor = UIColor(red: 219, green: 237, blue: 239, alpha: 1.0)
    }

}
