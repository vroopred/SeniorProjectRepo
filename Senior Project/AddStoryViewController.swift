//
//  AddStoryViewController.swift
//  Senior Project
//
//  Created by Varsha Roopreddy on 5/10/16.
//  Copyright © 2016 Anusha Praturu & Varsha Roopreddy. All rights reserved.
//

import Foundation
import UIKit

class AddStoryViewController: UIViewController {

   @IBOutlet weak var storyTitle: UITextField!
   @IBOutlet weak var author: UITextField!
   @IBOutlet weak var location: UITextField!
   @IBOutlet weak var storyContent: UITextView!
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   @IBAction func createStory(sender: AnyObject) {
      let ref = Firebase(url : "https://blazing-fire-252.firebaseio.com/Story")
      let story =  Story(title: storyTitle.text!, author: curUser.firstName + " " + curUser.lastName, content: storyContent.text!, location: location.text!, date: NSDate())
      let ref1 = ref.childByAutoId()
      ref1.setValue(story.toAnyObject())
      
      
      
       self.dismissViewControllerAnimated(true, completion: nil)
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let tbController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
      let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
      appDelegate.window?.rootViewController = tbController
   }
}