//
//  Extensions.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 14/2/23.
//

import Foundation
import UIKit
import CoreLocation

extension UIImageView {
    func setImage(url: String){
        guard let url = URL(string: url) else { return }
        downloadImage(url: url) { [weak self] image in
            guard let self = self else{ return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
    }
    
    private func downloadImage(url: URL, completion: @escaping(UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
}


extension MapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        
        if #available(iOS 14.0, *){
            switch manager.authorizationStatus{
            case .notDetermined:
                debugPrint("Not determined")
            case .restricted:
                debugPrint("Restricted")
            case .denied:
                debugPrint("Denied")
            case .authorizedAlways:
                debugPrint("Authorized always")
            case .authorizedWhenInUse:
                debugPrint("Authrozed when in use")
            @unknown default:
                debugPrint("Unknown status")
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
            switch manager.authorizationStatus{
            case .notDetermined:
                debugPrint("Not determined")
            case .restricted:
                debugPrint("Restricted")
            case .denied:
                debugPrint("Denied")
            case .authorizedAlways:
                debugPrint("Authorized always")
            case .authorizedWhenInUse:
                debugPrint("Authrozed when in use")
            @unknown default:
                debugPrint("Unknown status")
            }
    }
    
}
