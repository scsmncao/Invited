//
//  AddEventViewController.swift
//  Invited
//
//  Created by Simon Cao on 1/3/16.
//  Copyright © 2016 Change. All rights reserved.
//

import UIKit
import Parse

class AddEventViewController: UIViewController {
    @IBOutlet var name: UITextField!
    @IBOutlet var time: UITextField!
    @IBOutlet var eventDescription: UITextField!
    @IBOutlet var location: UITextField!
    @IBOutlet var createEventButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        createEventButton.backgroundColor = UIColor(red: 0.0, green: 64.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        cancelButton.backgroundColor = UIColor(red: 0.47, green: 0.47, blue: 0.47, alpha: 1.0)
        
        //add padding to the left of the text fields
        addLeftPaddingAndBorder(name)
        addLeftPaddingAndBorder(time)
        addLeftPaddingAndBorder(eventDescription)
        addLeftPaddingAndBorder(location)
    }
    
    // This function adds a left padding to the text field parameter and also a bottom border
    func addLeftPaddingAndBorder(textField: UITextField) {
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextFieldViewMode.Always
        
        let borderUser = CALayer()
        let width = CGFloat(1.0)
        borderUser.borderColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.0).CGColor
        borderUser.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        
        borderUser.borderWidth = width
        textField.layer.addSublayer(borderUser)
        textField.layer.masksToBounds = true
    }
    
    @IBAction func backgroundTapped(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func pickingDate(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        time.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    @IBAction func addEvent(sender: AnyObject) {
        let eventObject = PFObject(className:"Events")
        eventObject["Title"] = self.name.text!;
        
//        let formatter = NSDateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
//        let date = formatter.dateFromString(self.time.text!)
        eventObject["Date"] = self.time.text!
        
        eventObject["Location"] = self.location.text!
        eventObject["Description"] = self.eventDescription.text!
        eventObject["User"] = PFUser.currentUser()
        
        // get longitude and latitude from address
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(self.location.text!, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let placemark = placemarks?.first {
                print("\(self.location.text!)")
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                let location = PFGeoPoint(latitude: coordinates.latitude, longitude: coordinates.longitude)
                print("\(location)")
                eventObject["Position"] = location
                
                //after getting the location, save the event object
                eventObject.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        print("did not add event")
                    }
                }
            }
        })
    }
    
    func checkFields() {
        
    }
    
    @IBAction func dismissController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
}
