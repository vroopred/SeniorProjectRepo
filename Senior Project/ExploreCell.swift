//
//  ExploreCell.swift
//  Senior Project
//
//  Created by Varsha Roopreddy on 5/2/16.
//  Copyright © 2016 Anusha Praturu & Varsha Roopreddy. All rights reserved.
//

import UIKit

class ExploreCell: UITableViewCell {
   /*@IBOutlet weak var storyTitle: UILabel!
   @IBOutlet weak var userName: UILabel!
   @IBOutlet weak var location: UILabel!
   @IBOutlet weak var storyText: UITextView!
   @IBOutlet weak var timeAgoSinceDate: UILabel!*/
   
   @IBOutlet weak var storyTitle: UILabel!
   @IBOutlet weak var username: UILabel!
   @IBOutlet weak var location: UILabel!
   @IBOutlet weak var storyText: UITextView!
   @IBOutlet weak var timeAgoSinceDate: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }
   
   override func setSelected(selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      // Configure the view for the selected state
   }
}
