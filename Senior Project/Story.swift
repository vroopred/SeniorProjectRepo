//
//  Story.swift
//  Senior Project
//
//  Created by Varsha Roopreddy on 4/19/16.
//  Copyright © 2016 Anusha Praturu & Varsha Roopreddy. All rights reserved.
//

import Foundation

class Story {
   var title : String
   var author : String
   var content : String
   var location : String
   
   init(title: String, author: String, content : String, location : String) {
      self.title = title
      self.author = author
      self.content = content
      self.location = location
   }
}