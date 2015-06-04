//
//  ViewController.swift
//  navigating
//
//  Created by Alicia Iott on 5/16/15.
//  Copyright (c) 2015 Alicia Iott. All rights reserved.
//

import UIKit
import Parse
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate   {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        mapView.showsUserLocation = true
        mapView.delegate = self
        var locValue:CLLocationCoordinate2D = locationManager.location.coordinate
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(locValue, 400, 400), animated: true)
        
        var soundQuery = PFQuery(className:"Sounds")
        soundQuery.findObjectsInBackgroundWithBlock {
            (sounds: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(sounds!.count) sounds.")
                for sound in sounds!{
                    let titleString = sound["title"]! as! String
                    let loc = sound["location"]! as! PFGeoPoint
                    
                    let soundAnnotation = Sound(title: titleString,
                        locationName: "some location",
                        discipline: "public",
                        coordinate: CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude))
                    
                    self.mapView.addAnnotation(soundAnnotation)
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        println(userLocation.coordinate.latitude)
        println(userLocation.coordinate.longitude)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

