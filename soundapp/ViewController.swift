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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //if user is not logged in: self.performSegueWithIdentifier("goto_login", sender: self)
        //if user is logged in: nothing
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            let location = CLLocationCoordinate2D(latitude: 51.50007773,longitude: -0.1246402)
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
            
        } else {
            self.performSegueWithIdentifier("goto_login", sender: self)
        }
    }
    
    
}

