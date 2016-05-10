//
//  LoginViewController.swift
//  Senior Project
//
//  Created by Anusha Praturu on 4/28/16.
//  Copyright © 2016 Anusha Praturu & Varsha Roopreddy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && CURRENT_USER.authData != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tbController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = tbController
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginAction(sender: AnyObject) {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        if email != "" && password != "" {
            FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                if(error == nil) {
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    
                    let ref = Firebase(url : "https://blazing-fire-252.firebaseio.com/User/" + authData.uid)

                    ref.observeEventType(.Value, withBlock: { snapshot in
                        curUser = User(snapshot: snapshot)
                        }, withCancelBlock: { error in
                            print(error.description)
                    })
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tbController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.window?.rootViewController = tbController
                }
                else {
                    print(error)
                }
            
            })
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Enter email and password.", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alert.addAction(action)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

}
