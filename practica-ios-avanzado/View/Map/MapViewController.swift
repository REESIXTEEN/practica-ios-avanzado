//
//  MapViewController.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 14/2/23.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let viewModel: MapViewModel = MapViewModel()
    
    var locationManager: CLLocationManager?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let heroes = viewModel.getLocations()
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        mapView.delegate = self
        mapView.mapType = .standard
        
        for hero in heroes {
            addCustomPin(hero)
        }

    }
    
    private func addCustomPin(_ heroe: HeroeEntity) {
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: heroe.latitude, longitude: heroe.longitude)
        pin.title = heroe.name
        pin.subtitle = "aazaasddececvefvefv"
        mapView.addAnnotation(pin)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        let CalloutView = Bundle.main.loadNibNamed("CustomCallout", owner: self, options: nil)?.first as! UIView

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
            annotationView?.detailCalloutAccessoryView = CalloutView
        }
        else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "pin")

        return annotationView
    }
    
    

}



