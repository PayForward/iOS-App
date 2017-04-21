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
    var description: String!
    var image: UIImage!
    var price: Double!
    var specifiedTime: String?
    var type: PostType!
    var postTime: String!
    var location: [String: Any]!
}
