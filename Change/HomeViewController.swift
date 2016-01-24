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
    
    @IBOutlet var getStartedButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getStartedButton.backgroundColor = UIColor.whiteColor()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
    }
}
