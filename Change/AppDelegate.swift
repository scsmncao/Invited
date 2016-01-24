//
//  AppDelegate.swift
//  Change
//
//  Created by Simon Cao on 12/31/15.
//  Copyright © 2015 Change. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard : UIStoryboard?;

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Parse.setApplicationId("8ZjD8zOSXxz3InkY9qmFdX7ZmDiUcmFpcyE8Sud4",
            clientKey: "ZlVbi1sVheFersu28eYQrIjt1jO2EkVaxFiokHUS")
        
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        self.storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle());
        if (PFUser.currentUser() != nil) {
            self.window?.rootViewController = self.storyboard?.instantiateViewControllerWithIdentifier("activeSession")
        }
        else {
            self.window?.rootViewController = self.storyboard?.instantiateViewControllerWithIdentifier("inactiveSession")
        }
        
        //nav bar color
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.0, green: 64.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [ NSFontAttributeName: UIFont(name: "System Font Thin", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        //tab bar color
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 0.0, green: 64.0/255.0, blue: 128.0/255.0, alpha: 1.0)], forState: .Selected)
        UITabBar.appearance().tintColor = UIColor(red: 0.0, green: 64.0/255.0, blue: 128.0/255.0, alpha: 1.0)

        
        return true
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject?) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }
    
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    //Make sure it isn't already declared in the app delegate (possible redefinition of func error)
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

