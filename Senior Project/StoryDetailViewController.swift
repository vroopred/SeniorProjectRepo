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
  
   var toggleState = 1
   
   var detailStory: Story?
   /*var detailStory: String? {
      didSet {
         configureView()
      }
   }*/
   @IBAction func likeButton(sender: AnyObject){
      let likeBtn = sender as! UIButton
      if toggleState == 1 {
         /*Code*/
         toggleState = 2
         /*let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 26))
         imageView.contentMode = .ScaleAspectFit
         let image = UIImage(named: "RedHeart")
         imageView.image = image*/
         likeBtn.setImage(UIImage(named:"RedHeart"),forState:UIControlState.Normal)
      } else {
         /*Code*/
         toggleState = 1
         /*let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 26))
         imageView.contentMode = .ScaleAspectFit
         let image = UIImage(named: "WhiteHeart")
         imageView.image = image*/
         likeBtn.setImage(UIImage(named:"WhiteHeart"),forState:UIControlState.Normal)
      }
      
   }
   func configureView() {
      storyTitle.text = detailStory?.title
      author.text = detailStory?.author
      location.text = detailStory?.location
      storyText.text = detailStory?.content
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      configureView()
      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
      imageView.contentMode = .ScaleAspectFit
      let image = UIImage(named: "Logo")
      imageView.image = image
      navigationItem.titleView = imageView
      
      let fixedWidth = storyText.frame.size.width
      storyText.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
      let newSize = storyText.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
      var newFrame = storyText.frame
      newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
      storyText.frame = newFrame;
   }
   
   /*override func viewDidAppear(animated: Bool) {
      let fixedWidth = storyText.frame.size.width
      storyText.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
      let newSize = storyText.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
      var newFrame = storyText.frame
      newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
      storyText.frame = newFrame;
      super.viewDidAppear(animated)
   }*/
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
   }
   
   /*override func viewWillAppear(animated: Bool) {
      storyTitle.text = detailStory
   }*/
}
