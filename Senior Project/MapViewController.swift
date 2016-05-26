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
   //var stories = [Story]()
    
   @IBOutlet var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
           //map.showsUserLocation = true
      map.delegate = self
      map.showsUserLocation = true
      let manager = CLLocationManager()
      /*if CLLocationManager.authorizationStatus() == .NotDetermined {
         manager.requestWhenInUseAuthorization()
      }*/
      /*else {
         map.showsUserLocation = true
      }*/
        
        let ref = Firebase(url : "https://blazing-fire-252.firebaseio.com/Story")
        
        // 1
        ref.observeEventType(.Value, withBlock: { snapshot in
            
            // 2
            //var newItems = [Story]()
            
            // 3
            for item in snapshot.children {
                
                // 4
                let s = Story(snapshot: item as! FDataSnapshot)
                let pin = Pins(title: s.location,
                    locationName: s.address,
                    discipline: "Sculpture",
                    coordinate: CLLocationCoordinate2D(latitude: s.latitude,longitude: s.longitude))
                self.map.addAnnotation(pin)

                //newItems.append(story)
            }
            // 5
            
            //self.stories = newItems
        })
        
//
//        for s in self.stories {
//            print(s.location)
//            print(s.address)
//            print(s.longitude)
//            print(s.latitude)
//            let pin = Pins(title: s.location,
//                           locationName: s.address,
//                           discipline: "Sculpture",
//                           coordinate: CLLocationCoordinate2D(latitude: s.latitude,longitude: s.longitude))
//            map.addAnnotation(pin)
//        }
        
      let status = CLLocationManager.authorizationStatus()
      if status == CLAuthorizationStatus.NotDetermined {
         manager.requestWhenInUseAuthorization()
      } else if  status != .Denied {
         manager.startUpdatingLocation()
      }
      if CLLocationManager.locationServicesEnabled() {
         manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
         manager.startUpdatingLocation()
      }
        


      
      let pin = Pins(title: "Rec Center",
         locationName: "Cal Poly SLO",
         discipline: "Sculpture",
         coordinate: CLLocationCoordinate2D(latitude: 35.3050, longitude: -120.6625))
        
      let pin1 = Pins(title: "New Pin",
                      locationName: "Cal Poly SLO",
                      discipline: "Sculpture",
                      coordinate: CLLocationCoordinate2D(latitude: 30.3050, longitude: -125.6625))
      
      map.addAnnotation(pin)
      map.addAnnotation(pin1)
        
        
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
   func manager(locationManager: CLLocationManager, didUpdateLocations locations: [CLLocation])
   {
      
      let location = locations.last! as CLLocation
      
      let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
      let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
      
      map.setRegion(region, animated: true)
   }

}
extension UIViewController: MKMapViewDelegate {
   public func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
      
      let coordinate = userLocation.coordinate; // this sets the var coordinates to the location of the user.
      
      print("User Location = (\(coordinate.latitude), \(coordinate.longitude))");
      
         let locationOfDevice: CLLocation = userLocation.location! // this determines the location of the device using the users location
         
         let deviceCoordinate: CLLocationCoordinate2D = locationOfDevice.coordinate // determines the coordinates of the device using the location device variabel which has in it the user location.
         
         let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1) // this determines the span in which its determined that 1 degree is 69 miles.
         
         let region = MKCoordinateRegion(center: deviceCoordinate, span: span) // set the center equal to the device coordinates and the span equal to the span variable we have created this will give you the region.
         
      mapView.setRegion(region, animated: true);
       
   }
}


