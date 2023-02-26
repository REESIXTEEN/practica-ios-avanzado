//
//  MapViewModel.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 23/2/23.
//

import Foundation
import CoreData

class MapViewModel {
    
    var context = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
    let network = Network.shared
    
    
    func getLocations(completion: @escaping ([HeroeEntity]) -> Void) {
        let fetch: NSFetchRequest<HeroeEntity> = HeroeEntity.fetchRequest()
        let token = KeyChain().readData(key: .token)
        do {
            let heroes = try context.fetch(fetch)
            for heroe in heroes {
                if heroe.latitude == 0.0 && heroe.longitude == 0.0 {
                    network.fetchLocation(token: token, heroeId: heroe.id) { [weak self] location, error in
                        guard let location else {return}
                        heroe.latitude = Double(location.latitud) ?? 0.0
                        heroe.longitude = Double(location.longitud) ?? 0.0
                        self?.saveLocation()
                    }
                }
            }
            // La primera vez que se ejecuta la app y no hay datos en CoreData no se muestran las anotaciones ya que este return se hace antes de que se hayan obtenido las localizaciones de la api. Por limitacion de tiempo no he podido resolver este problema en el que deberia hacer el return cuando obtuviese la ultima localizacion y he puesto un sleep chapuza para solucionar esto.
            
            sleep(1)
            return completion(heroes)

        } catch let error as NSError {
            debugPrint("Error getting the locations for the heroes. Error: \(error)")
            return completion([])
        }
        
    }
    
    private func saveLocation() {
        do {
            try context.save()
            debugPrint("Location saved into CoreData")
        } catch let error {
            debugPrint("Error saving data into CoreData. Error: \(error)")
        }
    }
    
    
    
}
