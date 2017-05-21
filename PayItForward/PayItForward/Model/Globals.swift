//
//  Globals.swift
//  PayItForward
//
//  Created by Pankaj Khillon on 5/21/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

/// Returns an alert view controller which you can present
func createWarningAlert(withTitle title: String, message: String) -> UIViewController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(.init(title: "OK", style: .default, handler: nil))
    
    return alertController
}

enum AddressShareChoice {
    case Specific
    case General
}
