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
        
        let heroes = viewModel.getLocations()
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        mapView.delegate = self
        mapView.mapType = .standard
        
        heroes.forEach({addCustomPin($0)})

    }
    
    private func addCustomPin(_ heroe: HeroeEntity) {
        let pin = Annotation(heroe: heroe)
        mapView.addAnnotation(pin)
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


