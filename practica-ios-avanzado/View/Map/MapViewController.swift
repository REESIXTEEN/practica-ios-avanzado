//
//  MapViewController.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 14/2/23.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var locationManager: CLLocationManager?
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self

        
    }

}


