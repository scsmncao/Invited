//
//  MeViewController.swift
//  Invited
//
//  Created by Simon Cao on 1/4/16.
//  Copyright © 2016 Change. All rights reserved.
//

import UIKit
import Parse

class MeViewController: UIViewController {
    
    @IBAction func signOut(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("loggedOut", sender: self)
    }
}
