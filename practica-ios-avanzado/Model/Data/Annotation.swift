//
//  Annotation.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 26/2/23.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let heroe: HeroeEntity
    let name: String
    
    init(heroe: HeroeEntity) {
        coordinate = CLLocationCoordinate2D(latitude: heroe.latitude, longitude:   heroe.longitude)
        self.heroe = heroe
        self.name = heroe.name!
    }
    
}
