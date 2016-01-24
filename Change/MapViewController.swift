//
//  MapViewController.swift
//  Invited
//
//  Created by Simon Cao on 1/3/16.
//  Copyright © 2016 Change. All rights reserved.
//

import UIKit
import Parse
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    @IBOutlet var mapView: MKMapView!
    
    @IBAction func showAddEventController(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewControllerWithIdentifier("AddEvent") as! AddEventViewController
        self.presentViewController(vc, animated: true, completion: nil)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        // getting the current location of the user
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
        let center = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        // set the map region to the user's location
        self.mapView.setRegion(region, animated: true)
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        // using Parse to get current location and the nearest events
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                // Create a query for places
                let query = PFQuery(className:"Events")
                // Interested in locations near user.
                query.whereKey("Position", nearGeoPoint:geoPoint!, withinMiles: 5)
                do {
                    let nearbyPoints = try query.findObjects()
                    
                    // loop through the PFObjects list, nearbyPoints, and add annotations for them on the map
                    for points in nearbyPoints {
                        let point = points["Position"] as! PFGeoPoint
                        let locCoord = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = locCoord
                        annotation.title = points["Title"] as? String
                        annotation.subtitle = points["Location"] as? String
                        
                        self.mapView.addAnnotation(annotation)
                    }
                } catch {
                    print(error)
                }
                
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
}
