//
//  HomeViewController.swift
//  Change
//
//  Created by Simon Cao on 1/1/16.
//  Copyright © 2016 Change. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    var logInViewController: PFLogInViewController! = PFLogInViewController()
    var signUpViewController: PFSignUpViewController! = PFSignUpViewController()
    @IBOutlet var getStartedButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStartedButton.backgroundColor = UIColor.whiteColor()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (PFUser.currentUser() == nil) {
        
        }
    }
    
    
    @IBAction func logIn(sender: AnyObject) {
        //self.presentViewController(self.logInViewController, animated: true, completion: nil)
        self.performSegueWithIdentifier("signIn", sender: self)
    }
    
    @IBAction func signOut(sender: AnyObject) {
        PFUser.logOut()
    }
}
