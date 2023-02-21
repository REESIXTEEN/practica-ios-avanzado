//
//  CoreData.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 21/2/23.
//

import Foundation
import CoreData

class CoreData {
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var storeContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _ , error in
            if let error {
                debugPrint("Error during loading persistent stores \(error)")
            }
        }
        
        return container
    }()
    
    lazy var managedContext : NSManagedObjectContext = self.storeContainer.viewContext
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            debugPrint("Error during saving context \(error)")
        }
    }
    
}
