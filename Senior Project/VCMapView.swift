//
//  VCMapView.swift
//  Senior Project
//
//  Created by Varsha Roopreddy on 3/8/16.
//  Copyright © 2016 Anusha Praturu & Varsha Roopreddy. All rights reserved.
//

import Foundation
import MapKit

extension MapViewController: MKMapViewDelegate {
   
   // 1
   func map(map: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
      if let annotation = annotation as? Pins {
         let identifier = "pin"
         var view: MKPinAnnotationView
         if let dequeuedView = map.dequeueReusableAnnotationViewWithIdentifier(identifier)
            as? MKPinAnnotationView { // 2
               dequeuedView.annotation = annotation
               view = dequeuedView
         } else {
            // 3
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
         }
         return view
      }
      return nil
   }
}
