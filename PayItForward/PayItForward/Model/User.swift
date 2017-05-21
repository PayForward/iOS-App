//
//  User.swift
//  PayItForward
//
//  Created by Pankaj Khillon on 4/21/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import Foundation

class User {
    static let shared = User()
    
    var uid: String!
    var firstName: String!
    var lastName: String!
    var phoneNum: String?
    var communities = [String]() // cid
    var points: Int!
    var posts = [String]()       // can then load later from pid
    var following = [String]()    // uid
    var followers = [String]()    // uid
    var address: String!
    var shareChoice: AddressShareChoice!
    var travelChoice: Int!
}
