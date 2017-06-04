//
//  Globals.swift
//  PayItForward
//
//  Created by Pankaj Khillon on 5/21/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

public let paddingConstant: CGFloat = 5

/// Returns an alert view controller which you can present
func createWarningAlert(withTitle title: String, message: String) -> UIViewController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(.init(title: "OK", style: .default, handler: nil))
    
    return alertController
}

func scale(image: UIImage, toWidth width: CGFloat) -> UIImage? {
    let scaleFactor = width / image.size.width
    let newImageHeight = image.size.height * scaleFactor
    
    UIGraphicsBeginImageContext(CGSize(width: width, height: newImageHeight))
    image.draw(in: CGRect(x: 0, y: 0, width: width, height: newImageHeight))
    
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return scaledImage
}

enum AddressShareChoice {
    case Specific
    case General
}

extension UITextField {
    
    func pad(by amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: amount))
        
        self.leftView = paddingView
        self.leftViewMode = .always
        
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
