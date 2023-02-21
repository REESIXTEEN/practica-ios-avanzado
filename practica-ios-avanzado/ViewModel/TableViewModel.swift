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
    
    
    
    
}
