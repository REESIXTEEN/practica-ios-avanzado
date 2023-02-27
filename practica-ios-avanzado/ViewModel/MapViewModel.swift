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
    
    func getLocations() -> [HeroeEntity] {
        do {
            let fetch: NSFetchRequest<HeroeEntity> = HeroeEntity.fetchRequest()
            let heroes = try context.fetch(fetch)
            return heroes

        } catch let error as NSError {
            debugPrint("Error getting the locations for the heroes. Error: \(error)")
            return []
        }
        
    }

}
