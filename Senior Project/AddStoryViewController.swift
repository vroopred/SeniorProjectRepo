//
//  AddStoryViewController.swift
//  Senior Project
//
//  Created by Varsha Roopreddy on 5/10/16.
//  Copyright © 2016 Anusha Praturu & Varsha Roopreddy. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class AddStoryViewController: UIViewController {

   @IBOutlet weak var storyTitle: UITextField!
   @IBOutlet weak var location: UITextField!
   @IBOutlet weak var storyContent: UITextView!
    
   var resultsViewController: GMSAutocompleteResultsViewController?
   var searchController: UISearchController?
   var resultView: UITextView?
   var locString: NSString = ""
    var locCoord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 35.3050, longitude: -120.6625)
    
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
    
      resultsViewController = GMSAutocompleteResultsViewController()
      resultsViewController?.delegate = self
    
      searchController = UISearchController(searchResultsController: resultsViewController)
      searchController?.searchResultsUpdater = resultsViewController
    
      // Put the search bar in the navigation bar.
      searchController?.searchBar.sizeToFit()
      self.navigationItem.titleView = searchController?.searchBar
    
      // When UISearchController presents the results view, present it in
      // this view controller, not one further up the chain.
      self.definesPresentationContext = true
    
      // Prevent the navigation bar from being hidden when searching.
      searchController?.hidesNavigationBarDuringPresentation = false
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
    
    
   
   @IBAction func createStory(sender: AnyObject) {
      let ref = Firebase(url : "https://blazing-fire-252.firebaseio.com/Story")
    let story =  Story(title: storyTitle.text!, author: curUser.firstName + " " + curUser.lastName, content: storyContent.text!, location: locString as String, longitude: locCoord.longitude, latitude: locCoord.latitude, date: NSDate())
      let ref1 = ref.childByAutoId()
      ref1.setValue(story.toAnyObject())
      
      
      
       self.dismissViewControllerAnimated(true, completion: nil)
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let tbController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
      let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
      appDelegate.window?.rootViewController = tbController
   }
}

extension AddStoryViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWithPlace place: GMSPlace) {
        searchController?.active = false
        // Do something with the selected place.
        print("Place name: ", place.name)
        print("Place address: ", place.formattedAddress)
        print("Place ID: ", place.placeID)
        location.text = place.name
        locString = place.name
        locCoord = place.coordinate
    }
    
    func resultsController(resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: NSError){
        // TODO: handle the error.
        print("Error: ", error.description)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictionsForResultsController(resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictionsForResultsController(resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}