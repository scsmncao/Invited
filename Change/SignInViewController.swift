//
//  SignUpViewController.swift
//  Change
//
//  Created by Simon Cao on 12/31/15.
//  Copyright © 2015 Change. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseFacebookUtilsV4
import FBSDKCoreKit
import FBSDKLoginKit

class SignInViewController: UIViewController {
    
    
    @IBOutlet var facebookButton: UIButton!
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.actInd)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        // set loginbutton background color to red
//        loginButton.backgroundColor = UIColor(red: 0.40, green: 0.07, blue: 0.11, alpha: 1.0)
        
        //set facebook button background to facebook blue
        facebookButton.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
        
//        //draw in the bottom border for textfields
//        let borderUser = CALayer()
//        let width = CGFloat(1.0)
//        borderUser.borderColor = UIColor.darkGrayColor().CGColor
//        borderUser.frame = CGRect(x: 0, y: usernameField.frame.size.height - width, width:  usernameField.frame.size.width, height: usernameField.frame.size.height)
//        
//        borderUser.borderWidth = width
//        usernameField.layer.addSublayer(borderUser)
//        usernameField.layer.masksToBounds = true
//        
//        let borderPass = CALayer()
//        let widthPass = CGFloat(1.0)
//        borderPass.borderColor = UIColor.darkGrayColor().CGColor
//        borderPass.frame = CGRect(x: 0, y: usernameField.frame.size.height - widthPass, width:  usernameField.frame.size.width, height: usernameField.frame.size.height)
//        
//        borderPass.borderWidth = widthPass
//        passwordField.layer.addSublayer(borderPass)
//        passwordField.layer.masksToBounds = true
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        if let accessToken: FBSDKAccessToken = FBSDKAccessToken.currentAccessToken() {
            PFFacebookUtils.logInInBackgroundWithAccessToken(accessToken, block: {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    self.performSegueWithIdentifier("afterSignIn", sender: self)
                } else {
                    print("Uh oh. There was an error logging in.")
                }
            })
        }
        else {
            PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email", "user_friends"]) {
                (user: PFUser?, error: NSError?) -> Void in
                if let user = user {
                    if user.isNew {
                        self.performSegueWithIdentifier("afterSignIn", sender: self)
                    } else {
                        self.performSegueWithIdentifier("afterSignIn", sender: self)
                    }
                } else {
                    print("Uh oh. The user cancelled the Facebook login.")
                }
            }
        }
    }
    @IBAction func continueAsGuest(sender: AnyObject) {
        self.performSegueWithIdentifier("afterSignIn", sender: self)
    }
}