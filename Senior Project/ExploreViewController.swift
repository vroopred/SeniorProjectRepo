//
//  ExploreViewController.swift
//  Senior Project
//
//  Created by Varsha Roopreddy & Anusha Praturu on 2/22/16.
//  Copyright © 2016 Anusha Praturu & Varsha Roopreddy. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

   override func viewDidLoad() {
      super.viewDidLoad()
      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
      imageView.contentMode = .ScaleAspectFit
      let image = UIImage(named: "Logo")
      imageView.image = image
      navigationItem.titleView = imageView
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }


}

