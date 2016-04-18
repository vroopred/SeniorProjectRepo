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
   
 
    
    
   var storyTitles: [String] = ["First Story", "Second Story", "Third Story"]
   
   var users: [String] = ["Varsha", "Anusha", "ThirdUser"]
   
   var stories: [String] = ["This is story 1 content. This is story 1 content. This is story 1 content. This is story       1 content. This is story 1 content. This is story 1 content. ",
                            "This is story 2 content. This is story 2 content. This is story 2 content. This is story 2 content. This is story 2 content.",
                            "This is story 3 content. This is story 3 content. This is story 3 content. This is story 3 content. This is story 3 content."]
    
    var myRootRef = Firebase(url:"https://blazing-fire-252.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      self.HomeTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.storyTitles.count;
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
      let cell:HomeCell = self.tableView.dequeueReusableCellWithIdentifier("HomeCell") as! HomeCell
      
      cell.storyTitle.text = self.storyTitles[indexPath.row]
      
      cell.userName.text = self.users[indexPath.row]
      
      cell.storyText.text = self.stories[indexPath.row]
    
      myRootRef.setValue("test!!! writing to db.")
      
      return cell
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
