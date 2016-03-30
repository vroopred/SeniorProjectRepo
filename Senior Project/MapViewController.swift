//
//  MapViewController.swift
//  Senior Project
//
//  Created by Varsha Roopreddy on 2/24/16.
//  Copyright © 2016 Anusha Praturu & Varsha Roopreddy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

   @IBOutlet var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
           //map.showsUserLocation = true
      map.delegate = self
      let manager = CLLocationManager()
      if CLLocationManager.authorizationStatus() == .NotDetermined {
         manager.requestWhenInUseAuthorization()
      }
      else {
         map.showsUserLocation = true
      }
      
      if CLLocationManager.locationServicesEnabled() {
         manager.startUpdatingLocation()
      }
      
      let pin = Pins(title: "King David Kalakaua",
         locationName: "Waikiki Gateway Park",
         discipline: "Sculpture",
         coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
      
      map.addAnnotation(pin)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
   

}


