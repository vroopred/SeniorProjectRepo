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
    
    init(firstName: String, lastName : String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init(snapshot: FDataSnapshot) {
        firstName = snapshot.value["firstname"] as! String
        lastName = snapshot.value["lastname"] as! String
    }
    
    func toAnyObject() -> NSDictionary {
        return [
            "firstName": firstName,
            "lastName": lastName
        ]
    }
}