//
//  UIColor+Hex.swift
//  PayItForward
//
//  Created by Pankaj Khillon on 5/7/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// View background color (instead of white)
    class var backgroundColor: UIColor {
        return UIColor(red: 247, green: 245, blue: 243, alpha: 1.0)
    }
    
    /// Use for inactive icons
    class var inactive: UIColor {
        return UIColor(red: 193, green: 190, blue: 184, alpha: 1.0)
    }
    
    /// Active icons, header, PayItForward main color
    class var main: UIColor {
        return UIColor(red: 62, green: 158, blue: 167, alpha: 1.0)
    }
    
    /// Earnings and Request posts
    class var request: UIColor {
        return UIColor(red: 28, green: 124, blue: 84, alpha: 1.0)
    }
    
    /// Redeems and Offers
    class var offer: UIColor {
        return UIColor(red: 204, green: 41, blue: 54, alpha: 1.0)
    }
    
    /// All text
    class var text: UIColor {
        return UIColor(red: 54, green: 54, blue: 54, alpha: 1.0)
    }
    
    
    
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
