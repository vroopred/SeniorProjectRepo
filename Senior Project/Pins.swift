//
//  Pins.swift
//  Senior Project
//
//  Created by Varsha Roopreddy on 3/8/16.
//  Copyright © 2016 Anusha Praturu & Varsha Roopreddy. All rights reserved.
//

import Foundation
import MapKit

class Pins: NSObject, MKAnnotation {
   let title: String?
   let locationName: String
   let discipline: String
   let coordinate: CLLocationCoordinate2D
   
   init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
      self.title = title
      self.locationName = locationName
      self.discipline = discipline
      self.coordinate = coordinate
      
      super.init()
   }
   
   var subtitle: String? {
      return locationName
   }
}
