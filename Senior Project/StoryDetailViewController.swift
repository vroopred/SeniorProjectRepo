//
//  StoryDetailViewController.swift
//  Senior Project
//
//  Created by Varsha Roopreddy on 4/19/16.
//  Copyright © 2016 Anusha Praturu & Varsha Roopreddy. All rights reserved.
//

import UIKit

class StoryDetailViewController: UIViewController {

   @IBOutlet weak var storyTitle: UILabel!
   @IBOutlet weak var author: UILabel!
   @IBOutlet weak var location: UILabel!
   @IBOutlet weak var storyText: UITextView!
   
   var detailStory: Story?
   /*var detailStory: String? {
      didSet {
         configureView()
      }
   }*/
   
   func configureView() {
            //storyTitle.text = detailStory?.title
            author.text = detailStory?.author
            location.text = detailStory?.location
            storyText.text = detailStory?.content
            //candyImageView.image = UIImage(named: detailCandy.name)
            //title = detailCandy.category
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      configureView()
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
   }
   
   /*override func viewWillAppear(animated: Bool) {
      storyTitle.text = detailStory
   }*/
}
