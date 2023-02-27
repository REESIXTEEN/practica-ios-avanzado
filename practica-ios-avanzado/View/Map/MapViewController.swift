//
//  MapViewController.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 14/2/23.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, MyViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let viewModel: MapViewModel = MapViewModel()
    
    var locationManager: CLLocationManager?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager = CLLocationManager()
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.delegate = self
        self.mapView.delegate = self
        self.mapView.mapType = .standard
        
        let heroes = viewModel.getLocations()
        addAnnotations(heroes)
        
    }
    
    private func addAnnotations(_ heroes: [HeroeEntity]) {
        for heroe in heroes {
            let pin = Annotation(heroe: heroe)
            mapView.addAnnotation(pin)
        }

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation as! Annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
            let callout = Callout(annotation: annotation as! Annotation)
            callout.delegate = self
            annotationView?.detailCalloutAccessoryView = callout
        }
        else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "pin")

        return annotationView
    }
    
    
    func detailsTapped(heroe: HeroeEntity) {
        let detailsView = DetailViewController()
        detailsView.heroe = heroe
        navigationController?.pushViewController(detailsView, animated: true)
    }

}


