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
   @IBOutlet weak var followButton: UIButton!
  
   var toggleState = 1
   var followToggleState = 1
   var authorKey = ""
   var detailStory: Story?
   
   func incrementFollowers(username: String) {
      //increment the following count of the current user
      var numFollowing = 0
      var ref = Firebase(url : "https://blazing-fire-252.firebaseio.com/User")
      ref = ref.childByAppendingPath(CURRENT_USER.authData.uid);
      ref.observeEventType(.Value, withBlock: { snapshot in
         numFollowing = snapshot.value["numFollowing"] as! Int
         }, withCancelBlock: { error in
            print(error.description)
      })
      let ref2 = Firebase(url : "https://blazing-fire-252.firebaseio.com/User")
      ref = ref.childByAppendingPath(CURRENT_USER.authData.uid);
      numFollowing = numFollowing+1
      let following = ["numFollowing": numFollowing]
      ref2.updateChildValues(following)
      
      //increment the follower count of the story author
      /*var numFollowers = 0
      var ref = Firebase(url : "https://blazing-fire-252.firebaseio.com/User")
      ref = ref.childByAppendingPath(CURRENT_USER.authData.uid);
      ref.observeEventType(.Value, withBlock: { snapshot in
         numFollowers = snapshot.value["numFollowing"] as! Int
         }, withCancelBlock: { error in
            print(error.description)
      })
      var ref2 = Firebase(url : "https://blazing-fire-252.firebaseio.com/Story")
      ref2 = ref2.childByAppendingPath(title);
      numFollowers = numFollowers+1
      let followers = ["numFollowers": numFollowers]
      ref2.updateChildValues(followers)
      getKeyOfUser(username)*/
   }
   
   func decrementFollowers(username: String) {
      //decrement the followers count of the user of the story
      var numFollowing = 0
      var ref = Firebase(url : "https://blazing-fire-252.firebaseio.com/User")
      ref = ref.childByAppendingPath(CURRENT_USER.authData.uid);
      ref.observeEventType(.Value, withBlock: { snapshot in
         numFollowing = snapshot.value["numFollowing"] as! Int
         }, withCancelBlock: { error in
            print(error.description)
      })
      let ref2 = Firebase(url : "https://blazing-fire-252.firebaseio.com/User")
      ref = ref.childByAppendingPath(CURRENT_USER.authData.uid);
      numFollowing = numFollowing-1
      let following = ["numFollowing": numFollowing]
      ref2.updateChildValues(following)
      //decrement the following count of the current user
   }
   
   func setInitialFollowButton(username: String) {
      var ref = Firebase(url : "https://blazing-fire-252.firebaseio.com/User")
      ref = ref.childByAppendingPath(CURRENT_USER.authData.uid);
      ref = ref.childByAppendingPath("following")
      ref.observeEventType(.Value, withBlock: { snapshot in
         if(snapshot.hasChild(username)) {
            let isFollowing = snapshot.value[username] as! Bool
            if(isFollowing == true) {
               self.followButton.setTitle("Following", forState: UIControlState.Normal)
               self.followToggleState = 2
            }
            else {
               self.followButton.setTitle("Follow", forState: UIControlState.Normal)
               self.followToggleState = 1
            }
         }
         }, withCancelBlock: { error in
            print(error.description)
      })
   }
   
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
   
   @IBAction func followButton(sender: AnyObject) {
      if followToggleState == 1 {
         /*Code*/
         followToggleState = 2
         var ref = Firebase(url : "https://blazing-fire-252.firebaseio.com/User")
         ref = ref.childByAppendingPath(CURRENT_USER.authData.uid);
         let followRef = ref.childByAppendingPath("following")
         
         let followStruct = [self.author.text!: true]
         
         followRef.updateChildValues(followStruct)
         incrementFollowers(self.author.text!)
         
         self.followButton.setTitle("Following", forState: UIControlState.Normal)
      } else {
         /*Code*/
         followToggleState = 1
         var ref = Firebase(url : "https://blazing-fire-252.firebaseio.com/User")
         ref = ref.childByAppendingPath(CURRENT_USER.authData.uid);
         ref = ref.childByAppendingPath("following")
         ref = ref.childByAppendingPath(self.author.text!)
         ref.removeValue()
         decrementFollowers(self.author.text!)
        self.followButton.setTitle("Follow", forState: UIControlState.Normal)
      }
   }
   func configureView() {
      storyTitle.text = detailStory!.title
      author.text = detailStory!.author
      location.text = detailStory!.location
      storyText.text = detailStory!.content
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

      
      setInitialFollowButton(self.author.text!)
   }
   
   /*func getKeyOfUser(fullName: String){
      let fullNameArr = fullName.characters.split{$0 == " "}.map(String.init)
      let firstName: String = fullNameArr[0]
      let ref = Firebase(url : "https://blazing-fire-252.firebaseio.com/User")
      ref.observeEventType(.Value, withBlock: { snapshot in
         for item in snapshot.children {
            print(item.value["firstname"])
            if(item.value["firstname"] as! String == firstName) {
               self.authorKey = item.key
            }
         }
         }, withCancelBlock: { error in
            print(error.description)
      })
   }*/
   
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
