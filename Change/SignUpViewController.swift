//
//  SignUpViewController.swift
//  Change
//
//  Created by Simon Cao on 1/1/16.
//  Copyright © 2016 Change. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        signUpButton.backgroundColor = UIColor(red: 0.40, green: 0.07, blue: 0.11, alpha: 1.0)
        
        //draw in the bottom border for textfields
        let borderUser = CALayer()
        let width = CGFloat(1.0)
        borderUser.borderColor = UIColor.darkGrayColor().CGColor
        borderUser.frame = CGRect(x: 0, y: usernameField.frame.size.height - width, width:  usernameField.frame.size.width, height: usernameField.frame.size.height)
        
        borderUser.borderWidth = width
        usernameField.layer.addSublayer(borderUser)
        usernameField.layer.masksToBounds = true
        
        let borderPass = CALayer()
        let widthPass = CGFloat(1.0)
        borderPass.borderColor = UIColor.darkGrayColor().CGColor
        borderPass.frame = CGRect(x: 0, y: usernameField.frame.size.height - widthPass, width:  usernameField.frame.size.width, height: usernameField.frame.size.height)
        
        borderPass.borderWidth = widthPass
        passwordField.layer.addSublayer(borderPass)
        passwordField.layer.masksToBounds = true
        
    }
    
    @IBAction func signUpAction(sender: AnyObject) {
        
        let username = self.usernameField.text!
        let password = self.passwordField.text!
        if (username.characters.count < 4 || password.characters.count < 5) {
            let title = "Invalid"
            let message = "Username or password too short."
            let ac = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
            ac.addAction(cancelAction)
            self.presentViewController(ac, animated: true, completion: nil)
        }
        else {
            self.actInd.startAnimating()
            let newUser = PFUser()
            newUser.username = username
            newUser.password = password
            
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                self.actInd.stopAnimating()
                
                if (error != nil) {
                    let title = "Error"
                    let message = "Could not sign in user."
                    let signInError = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                    let cancelAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
                    signInError.addAction(cancelAction)
                    self.presentViewController(signInError, animated: true, completion: nil)
                }
                else {
                    self.performSegueWithIdentifier("afterSignUp", sender: self)
                }
            })
        }
        
    }
    
    @IBAction func showSignIn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.actInd)
    }
}