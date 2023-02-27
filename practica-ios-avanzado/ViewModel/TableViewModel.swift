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
    
    func getHeroes(completion: @escaping ([HeroeEntity]) -> Void) {
        let heroes = readFromCoreData()

        if heroes.isEmpty {
            let userToken = keyChain.readData(key: .token)
            network.fetchHeroes(token: userToken) { heroes, error in
                guard let heroes else {
                    debugPrint("Error getting the heroes from the api")
                    return completion([])
                }
                let nsHeroes = self.convertData(heroes)
                self.saveIntoCoreData()
                self.getLocations(nsHeroes, userToken)
                return completion(nsHeroes)
            }
        }else{
            return completion(heroes)
        }
    }
    
    
    private func readFromCoreData() -> [HeroeEntity] {
        let heroeFetch: NSFetchRequest<HeroeEntity> = HeroeEntity.fetchRequest()
        
        do {
            let result = try context.fetch(heroeFetch)
            debugPrint("Data readed from CoreData")
            return result
            
        } catch let error as NSError {
            debugPrint("Error getting data from core data -> \(error)")
            return []
        }
    }

    
    private func convertData(_ heroes: [Heroe]) -> [HeroeEntity] {
        var nsHeroes: [HeroeEntity] = []
        for heroe in heroes {
            let newHero: HeroeEntity = HeroeEntity(context: context)
            newHero.id = heroe.id
            newHero.name = heroe.name
            newHero.photo = heroe.photo
            newHero.details = heroe.description
            newHero.favorite = heroe.favorite
            newHero.latitude = 0.0
            newHero.longitude = 0.0
            nsHeroes.append(newHero)
        }
        return nsHeroes
    }
    
    private func getLocations(_ heroes: [HeroeEntity], _ userToken: String) {
        for heroe in heroes {
            network.fetchLocation(token: userToken, heroeId: heroe.id) { [weak self] location, error in
                guard let location else {return}
                heroe.latitude = Double(location.latitud) ?? 0.0
                heroe.longitude = Double(location.longitud) ?? 0.0
                self?.saveIntoCoreData()
            }
        }
    }
    
    
    private func saveIntoCoreData() {
        do {
            try context.save()
            debugPrint("Data saved into CoreData")
        } catch let error {
            debugPrint("Error saving data into CoreData. Error: \(error)")
        }
    }
    
    
    
}
