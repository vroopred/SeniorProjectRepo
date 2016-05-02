//
//  BaseService.swift
//  Senior Project
//
//  Created by Anusha Praturu on 4/28/16.
//  Copyright © 2016 Anusha Praturu & Varsha Roopreddy. All rights reserved.
//

import Foundation
//import Firebase

let BASE_URL = "https://blazing-fire-252.firebaseio.com/"

let FIREBASE_REF = Firebase(url: BASE_URL)

var CURRENT_USER: Firebase{
    let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    let currentUser = Firebase(url: "\(FIREBASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
    return currentUser!
}