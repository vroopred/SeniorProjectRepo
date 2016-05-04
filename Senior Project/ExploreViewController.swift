//
//  ExploreViewController.swift
//  Senior Project
//
//  Created by Varsha Roopreddy & Anusha Praturu on 2/22/16.
//  Copyright © 2016 Anusha Praturu & Varsha Roopreddy. All rights reserved.
//

import UIKit

class ExploreViewController: UITableViewController {

   @IBOutlet weak var refresh: UIRefreshControl!
   
   @IBOutlet var ExploreTable: UITableView!
   
   var stories = [Story]();
   var filteredStories = [Story]();
   let searchController = UISearchController(searchResultsController: nil)
   
   func filterContentForSearchText(searchText : String, scope: String = "All") {
      filteredStories = stories.filter{story in
         return story.title.lowercaseString.containsString(searchText.lowercaseString)}
      tableView.reloadData()
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
      imageView.contentMode = .ScaleAspectFit
      let image = UIImage(named: "Logo")
      imageView.image = image
      navigationItem.titleView = imageView
      //self.automaticallyAdjustsScrollViewInsets = false
      
      stories = [
         Story(title: "First Story", author: "Varsha R.", content: "This is story 1 content. This is story 1 content. This is story 1 content. This is story       1 content. This is story 1 content. This is story 1 content. ", location: "Fremont, CA", date: NSDate()),
         Story(title: "Second Story", author: "Anusha P.", content: "This is story 2 content. This is story 2 content. This is story 2 content. This is story 2 content. This is story 2 content. This is story 2 content. ", location: "San Luis Obispo, CA", date: NSDate()),
         Story(title: "Third Story", author: "Justin B.", content: "This is story 3 content. This is story 3 content. This is story 3 content. This is story 3 content. This is story 3 content. This is story 3 content. ", location: "San Francisco, CA", date: NSDate())
      ]
      
      self.ExploreTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
      
      searchController.searchResultsUpdater = self
      searchController.dimsBackgroundDuringPresentation = false
      definesPresentationContext = true
      tableView.tableHeaderView = searchController.searchBar
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
      if searchController.active && searchController.searchBar.text != "" {
         return filteredStories.count
      }
      return self.stories.count;
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
      let cell:ExploreCell = self.tableView.dequeueReusableCellWithIdentifier("ExploreCell") as! ExploreCell
      
      let story : Story
      
      if searchController.active && searchController.searchBar.text != "" {
         story = filteredStories[indexPath.row]
      } else {
         story = stories[indexPath.row]
      }
      
      let timeAgo:String = timeAgoSinceDate(story.date, numericDates: true)
      
      cell.storyTitle.text = story.title
      
      cell.username.text = story.author
      
      cell.location.text = story.location
      
      cell.storyText.text = story.content.trunc(100) 
      
      cell.timeAgoSinceDate.text = timeAgo
      
      
      return cell
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
      if segue.identifier == "ShowExploreStoryDetails" {
         if let indexPath = tableView.indexPathForSelectedRow {
            let story : Story
            if searchController.active && searchController.searchBar.text != "" {
               story = filteredStories[indexPath.row]
            } else {
               story = stories[indexPath.row]
            }
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
      }else {
         return "Just now"
      }
   }
}
extension ExploreViewController : UISearchResultsUpdating {
   func updateSearchResultsForSearchController(searchController : UISearchController) {
      filterContentForSearchText(searchController.searchBar.text!)
   }
}


