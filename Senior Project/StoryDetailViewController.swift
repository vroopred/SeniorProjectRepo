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
   @IBOutlet weak var likeButton: UIButton!
  
   var toggleState = 1
   
   var detailStory: Story?
   
   func incrementLikes(title: String) {
      var numLikes = 0
      var ref = Firebase(url : "https://blazing-fire-252.firebaseio.com/Story")
      ref = ref.childByAppendingPath(title);
      ref.observeEventType(.Value, withBlock: { snapshot in
            numLikes = snapshot.value["likes"] as! Int
         }, withCancelBlock: { error in
            print(error.description)
      })
      var ref2 = Firebase(url : "https://blazing-fire-252.firebaseio.com/Story")
      ref2 = ref2.childByAppendingPath(title);
      numLikes = numLikes+1
      let likes = ["likes": numLikes]
      ref2.updateChildValues(likes)
   }
   func decrementLikes(title: String) {
      var numLikes = 0
      var ref = Firebase(url : "https://blazing-fire-252.firebaseio.com/Story")
      ref = ref.childByAppendingPath(title);
      ref.observeEventType(.Value, withBlock: { snapshot in
         numLikes = snapshot.value["likes"] as! Int
         }, withCancelBlock: { error in
            print(error.description)
      })
      var ref2 = Firebase(url : "https://blazing-fire-252.firebaseio.com/Story")
      ref2 = ref2.childByAppendingPath(title);
      numLikes = numLikes-1
      let likes = ["likes": numLikes]
      ref2.updateChildValues(likes)
   }

   @IBAction func likeButton(sender: AnyObject){
      let likeBtn = sender as! UIButton
      if toggleState == 1 {
         /*Code*/
         toggleState = 2
         var ref = Firebase(url : "https://blazing-fire-252.firebaseio.com/User")
         ref = ref.childByAppendingPath(CURRENT_USER.authData.uid);
         let likeRef = ref.childByAppendingPath("likes")
         
         let likeStruct = [self.storyTitle.text!: true]
         
         likeRef.updateChildValues(likeStruct)
         incrementLikes(self.storyTitle.text!)
         
         likeBtn.setImage(UIImage(named:"RedHeart"),forState:UIControlState.Normal)
      } else {
         /*Code*/
         toggleState = 1
         var ref = Firebase(url : "https://blazing-fire-252.firebaseio.com/User")
         ref = ref.childByAppendingPath(CURRENT_USER.authData.uid);
         ref = ref.childByAppendingPath("likes")
         ref = ref.childByAppendingPath(self.storyTitle.text!)
         ref.removeValue()
         decrementLikes(self.storyTitle.text!)
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
      var ref = Firebase(url : "https://blazing-fire-252.firebaseio.com/User")
      ref = ref.childByAppendingPath(CURRENT_USER.authData.uid);
      ref = ref.childByAppendingPath("likes");
      ref.observeEventType(.Value, withBlock: { snapshot in
            if(snapshot.hasChild(self.storyTitle.text!)) {
               let didLike = snapshot.value[self.storyTitle.text!] as! Bool
               if(didLike == true) {
                  self.likeButton.setImage(UIImage(named:"RedHeart"),forState:UIControlState.Normal)
               }
               else {
                  self.likeButton.setImage(UIImage(named:"WhiteHeart"),forState:UIControlState.Normal)
               }
            }
         }, withCancelBlock: { error in
            print(error.description)
      })
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
