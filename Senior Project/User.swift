//
//  User.swift
//  Senior Project
//
//  Created by Anusha Praturu on 5/10/16.
//  Copyright © 2016 Anusha Praturu & Varsha Roopreddy. All rights reserved.
//

import Foundation

class User {
    var firstName : String
    var lastName : String
   var numFollowers : Int
   var numFollowing: Int
   
    init(firstName: String, lastName : String) {
        self.firstName = firstName
        self.lastName = lastName
         self.numFollowers = 0
         self.numFollowing = 0
    }
    
    init(snapshot: FDataSnapshot) {
        firstName = snapshot.value["firstname"] as! String
        lastName = snapshot.value["lastname"] as! String
         numFollowers = snapshot.value["numFollowers"] as! Int
      numFollowing = snapshot.value["numFollowing"] as! Int
    }
    
    func toAnyObject() -> NSDictionary {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "numFollowers": numFollowers,
            "numFollowing": numFollowing
        ]
    }
}