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
   var date : NSDate
   
   init(title: String, author: String, content : String, location : String, date: NSDate) {
      self.title = title
      self.author = author
      self.content = content
      self.location = location
      self.date = date
   }
   
   init(snapshot: FDataSnapshot) {
      title = snapshot.value["title"] as! String
      author = snapshot.value["author"] as! String
      content = snapshot.value["content"] as! String
      location = snapshot.value["location"] as! String
      let dateInterval = snapshot.value["date"] as! String
      let interval = NSTimeInterval((dateInterval as NSString).floatValue)
      date = NSDate(timeIntervalSince1970: interval)
   }
   
   func toAnyObject() -> NSDictionary {
      return [
         "title": title,
         "author": author,
         "content": content,
         "location": location,
         "date" : NSString(format: "%f", date.timeIntervalSince1970)
      ]
   }
}