//
//  HomeViewController.swift
//  Senior Project
//
//  Created by Varsha Roopreddy on 3/3/16.
//  Copyright © 2016 Anusha Praturu & Varsha Roopreddy. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController{

   @IBOutlet var HomeTable: UITableView!
    var stories = [Story]()
 
    
    
   /*var storyTitles: [String] = ["First Story", "Second Story", "Third Story"]
   
   var users: [String] = ["Varsha", "Anusha", "ThirdUser"]
   
   var stories: [String] = ["This is story 1 content. This is story 1 content. This is story 1 content. This is story       1 content. This is story 1 content. This is story 1 content. ",
                            "This is story 2 content. This is story 2 content. This is story 2 content. This is story 2 content. This is story 2 content.",
                            "This is story 3 content. This is story 3 content. This is story 3 content. This is story 3 content. This is story 3 content."]
   var storyInfo: [Story] =*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
         stories = [
            Story(title: "First Story", author: "Varsha R.", content: "This is story 1 content. This is story 1 content. This is story 1 content. This is story       1 content. This is story 1 content. This is story 1 content. ", location: "Fremont, CA"),
            Story(title: "Second Story", author: "Anusha P.", content: "This is story 2 content. This is story 2 content. This is story 2 content. This is story 2 content. This is story 2 content. This is story 2 content. ", location: "San Luis Obispo, CA"),
            Story(title: "Third Story", author: "Justin B.", content: "This is story 3 content. This is story 3 content. This is story 3 content. This is story 3 content. This is story 3 content. This is story 3 content. ", location: "San Francisco, CA")
         ]
            
      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
      imageView.contentMode = .ScaleAspectFit
      let image = UIImage(named: "Logo")
      imageView.image = image
      navigationItem.titleView = imageView
        // Do any additional setup after loading the view.
      self.HomeTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.stories.count;
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
      let cell:HomeCell = self.tableView.dequeueReusableCellWithIdentifier("HomeCell") as! HomeCell
      
      cell.storyTitle.text = self.stories[indexPath.row].title
      
      cell.userName.text = self.stories[indexPath.row].author
      
      cell.location.text = self.stories[indexPath.row].location
      
      cell.storyText.text = self.stories[indexPath.row].content
      
      return cell
   }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      if segue.identifier == "ShowStoryDetails" {
         if let indexPath = tableView.indexPathForSelectedRow {
            let story = stories[indexPath.row]
            let detailViewController = segue.destinationViewController
               as! StoryDetailViewController
            detailViewController.detailStory = story
         }
      }
    }
   

}
