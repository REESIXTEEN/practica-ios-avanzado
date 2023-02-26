//
//  UserViewModel.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 21/2/23.
//

import Foundation
import CoreData

class UserViewModel {
    
    let keyChain = KeyChain()
    var context = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
    
    func deleteUserData(){
        deleteCoreData()
    }
    
    func logOut() {
        keyChain.deleteData(key: .user)
        keyChain.deleteData(key: .password)
        keyChain.deleteData(key: .token)
    }
    
    func readData() -> String {
        let user = keyChain.readData(key: .user)
        return user != "" ? user : "Error loading user email"
    }
    
    private func deleteCoreData() {
        // No he tenido tiempo de arreglar el fallo que esto provoca al volver a la tabla
        // en la cual se produce un fallo, ya que esta intenta cargar datos que no existen ya
        
        let fetch: NSFetchRequest<HeroeEntity> = HeroeEntity.fetchRequest()
        
        do {
            let heroes = try context.fetch(fetch)
            for heroe in heroes {
                context.delete(heroe)
            }
            try context.save()
            debugPrint("Data from CoreData deleted.")
        } catch let error as NSError {
            debugPrint("Error deleting data from CoreData. Error: \(error)")
        }
    }
    
}
