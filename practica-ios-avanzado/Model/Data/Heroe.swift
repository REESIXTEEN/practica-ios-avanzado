//
//  Heroe.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 14/2/23.
//

import Foundation

struct Heroe: Codable {
    let id: String
    let name: String
    let photo: String
    let description: String
    let favorite: Bool
    let longitud: Double
    let latitud: Double
}