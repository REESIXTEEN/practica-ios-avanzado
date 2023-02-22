//
//  HeroeEntity.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 22/2/23.
//

import Foundation
import CoreData

@objc(HeroeEntity)
public class HeroeEntity: NSManagedObject, Identifiable {
    
}

public extension HeroeEntity {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<HeroeEntity> {
        return NSFetchRequest<HeroeEntity>(entityName: "HeroeEntity")
    }
    
    @NSManaged var name: String?
    @NSManaged var details: String?
    @NSManaged var id: String
    @NSManaged var favorite: Bool
    @NSManaged var photo: String?
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    
}
