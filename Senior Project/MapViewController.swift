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
      
      let pin = Pins(title: "Rec Center",
         locationName: "Cal Poly SLO",
         discipline: "Sculpture",
         coordinate: CLLocationCoordinate2D(latitude: 35.3050, longitude: -120.6625))
      
      map.addAnnotation(pin)
      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
      imageView.contentMode = .ScaleAspectFit
      let image = UIImage(named: "Logo")
      imageView.image = image
      navigationItem.titleView = imageView
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


