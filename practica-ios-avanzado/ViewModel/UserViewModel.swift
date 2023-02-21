//
//  UserViewModel.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 21/2/23.
//

import Foundation

class UserViewModel {
    
    let keyChain = KeyChain()
    
    
    func deleteUserData(){
        keyChain.deleteData(key: .user)
        keyChain.deleteData(key: .password)
        keyChain.deleteData(key: .token)
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
}
