//
//  HomeViewController.swift
//  Senior Project
//
//  Created by Varsha Roopreddy on 3/3/16.
//  Copyright © 2016 Anusha Praturu & Varsha Roopreddy. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController{

   @IBOutlet weak var refresh: UIRefreshControl!
   @IBOutlet var HomeTable: UITableView!
    var stories = [Story]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         stories = [
            Story(title: "First Story", author: "Varsha R.", content: "This is story 1 content. This is story 1 content. This is story 1 content. This is story       1 content. This is story 1 content. This is story 1 content. ", location: "Fremont, CA", date: NSDate()),
            Story(title: "Second Story", author: "Anusha P.", content: "This is story 2 content. This is story 2 content. This is story 2 content. This is story 2 content. This is story 2 content. This is story 2 content. ", location: "San Luis Obispo, CA", date: NSDate()),
            Story(title: "Third Story", author: "Justin B.", content: "This is story 3 content. This is story 3 content. This is story 3 content. This is story 3 content. This is story 3 content. This is story 3 content. ", location: "San Francisco, CA", date: NSDate())
         ]
            
      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
      imageView.contentMode = .ScaleAspectFit
      let image = UIImage(named: "Logo")
      imageView.image = image
      navigationItem.titleView = imageView
        // Do any additional setup after loading the view.
      self.HomeTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
      refresh.addTarget(self, action: #selector(HomeViewController.enlargeTable), forControlEvents: UIControlEvents.ValueChanged)
      tableView.addSubview(refresh)
   }
   
   func enlargeTable() {
      tableView.reloadData()
      refresh.endRefreshing()
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
      
      let timeAgo:String = timeAgoSinceDate(self.stories[indexPath.row].date, numericDates: true)
      
      cell.storyTitle.text = self.stories[indexPath.row].title
      
      cell.userName.text = self.stories[indexPath.row].author
      
      cell.location.text = self.stories[indexPath.row].location
      
      cell.storyText.text = self.stories[indexPath.row].content.trunc(100) + "..."
      
      cell.timeAgoSinceDate.text = timeAgo
    
      
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
   
   func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
      let calendar = NSCalendar.currentCalendar()
      let now = NSDate()
      let earliest = now.earlierDate(date)
      let latest = (earliest == now) ? date : now
      let components:NSDateComponents = calendar.components([NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Second], fromDate: earliest, toDate: latest, options: NSCalendarOptions())
      
      if (components.year >= 2) {
         return "\(components.year) years ago"
      } else if (components.year >= 1){
         if (numericDates){
            return "1 year ago"
         } else {
            return "Last year"
         }
      } else if (components.month >= 2) {
         return "\(components.month) months ago"
      } else if (components.month >= 1){
         if (numericDates){
            return "1 month ago"
         } else {
            return "Last month"
         }
      } else if (components.weekOfYear >= 2) {
         return "\(components.weekOfYear) weeks ago"
      } else if (components.weekOfYear >= 1){
         if (numericDates){
            return "1 week ago"
         } else {
            return "Last week"
         }
      } else if (components.day >= 2) {
         return "\(components.day) days ago"
      } else if (components.day >= 1){
         if (numericDates){
            return "1 day ago"
         } else {
            return "Yesterday"
         }
      } else if (components.hour >= 2) {
         return "\(components.hour) hours ago"
      } else if (components.hour >= 1){
         if (numericDates){
            return "1 hour ago"
         } else {
            return "An hour ago"
         }
      } else if (components.minute >= 2) {
         return "\(components.minute) minutes ago"
      } else if (components.minute >= 1){
         if (numericDates){
            return "1 minute ago"
         } else {
            return "A minute ago"
         }
      } else {
         return "Just now"
      }
      
   }

}

extension String {
   func trunc(length: Int, trailing: String? = "...") -> String {
      if self.characters.count > length {
         return self.substringToIndex(self.startIndex.advancedBy(length)) + (trailing ?? "")
      } else {
         return self
      }
   }
}
