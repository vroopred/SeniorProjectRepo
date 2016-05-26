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
   var longitude : Double
   var latitude : Double
   var address : String
   var date : NSDate
   var likes : Int
   
    init(title: String, author: String, content : String, location : String, longitude : Double, latitude : Double, address: String, date: NSDate) {
      self.title = title
      self.author = author
      self.content = content
      self.location = location
      self.longitude = longitude
      self.latitude = latitude
      self.address = address
      self.date = date
      self.likes = 0
   }
   
   init(snapshot: FDataSnapshot) {
      title = snapshot.value["title"] as! String
      author = snapshot.value["author"] as! String
      content = snapshot.value["content"] as! String
      location = snapshot.value["location"] as! String
      longitude = snapshot.value["longitude"] as! Double
      latitude = snapshot.value["latitude"] as! Double
      address = snapshot.value["address"] as! String
      likes = snapshot.value["likes"] as! Int
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
         "longitude": longitude,
         "latitude": latitude,
         "address": address,
         "likes": 0,
         "date" : NSString(format: "%f", date.timeIntervalSince1970)
      ]
   }
}