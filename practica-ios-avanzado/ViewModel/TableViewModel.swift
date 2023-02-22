//
//  TableViewModel.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 21/2/23.
//

import Foundation


class TableViewModel {
    
    let network = Network.shared
    let keyChain = KeyChain()
    
    var context = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
    
    func checkLogin() -> Bool {
        let loginStatus = keyChain.checkKeyExists(key: .token)
        return loginStatus
    }
    
    func getHeroes(completion: @escaping ([Heroe]) -> Void) {
        let userToken = keyChain.readData(key: .token)
        network.fetchHeroes(token: userToken) { heroes, error in
            guard let heroes else {
                debugPrint("Error getting the heroes from the api")
                return completion([])
            }
            return completion(heroes)
        }
    }
    
    
    
    
    
    
    
}
