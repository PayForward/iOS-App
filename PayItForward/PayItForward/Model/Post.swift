//
//  Post.swift
//  PayItForward
//
//  Created by Jonathan Abercrombie on 4/21/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import Foundation
import UIKit

enum PostType {
    case request
    case offer
}

class Post {    
    var title: String!
    var userFirstName: String!
    var userProfileImage: UIImage!
    var price: Double!
    var timeSinceEpochInSeconds: Double! 
    var specifiedTime: String?
    var type: PostType!
    var category: String!
    var subCategories: [String]!
    
    var exactDate: Date {
        return Date(timeIntervalSince1970: self.timeSinceEpochInSeconds)
    }
    
    lazy var details = PostDetails()
    
}

class PostDetails {
    
    var description: String!
    var location: (String, Bool)!
    
    // in case public = false, measured in meters
    var obfuscateFactor = Double(arc4random_uniform(50))
    var radius: Double?
    
}
