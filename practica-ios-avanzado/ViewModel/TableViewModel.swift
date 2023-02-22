//
//  TableViewModel.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 21/2/23.
//

import Foundation
import CoreData


class TableViewModel {
    
    let network = Network.shared
    let keyChain = KeyChain()
    
    var context = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
    
    func checkLogin() -> Bool {
        let loginStatus = keyChain.checkKeyExists(key: .token)
        return loginStatus
    }
    
    func getHeroes(completion: @escaping ([Heroe]) -> Void) {
        let heroes = getHeroesFromCoreData()

        if heroes.isEmpty {
            let userToken = keyChain.readData(key: .token)
            network.fetchHeroes(token: userToken) { heroes, error in
                guard let heroes else {
                    debugPrint("Error getting the heroes from the api")
                    return completion([])
                }
                return completion(heroes)
            }
        }else {
            
        }
        
        
    }
    
    
    private func getHeroesFromCoreData() -> [HeroeEntity] {
        let heroeFetch: NSFetchRequest<HeroeEntity> = HeroeEntity.fetchRequest()
        
        do {
            let result = try context.fetch(heroeFetch)
            return result
            
        } catch let error as NSError {
            debugPrint("Error getting data from core data -> \(error)")
            return []
        }
    }
    
    
    
    
}
