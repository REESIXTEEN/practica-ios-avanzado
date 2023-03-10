//
//  LoginViewModel.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 20/2/23.
//

import Foundation

enum loginResult: String {
    case email = "Incorrect email"
    case password = "Empty password"
    case success = "Success"
    case error = "An error has ocurred during login, maybe user and email incorrects"
}

class LoginViewModel {

    let network = Network.shared
    let keyChain = KeyChain()
    
    func login(userEmail: String?, password: String?, completion: @escaping(loginResult) -> Void) {
        guard let userEmail, !userEmail.isEmpty && userEmail.contains("@") else { return completion(.email) }
        guard let password, !password.isEmpty else { return completion(.password) }
        
        network.login(email: userEmail, password: password) { token, error in
            guard let token else {return completion(.error)}
            
            self.keyChain.saveData(key: .token, keyValue: token)
            self.keyChain.saveData(key: .user, keyValue: userEmail)
            self.keyChain.saveData(key: .password, keyValue: password)
            
            return completion(.success)
            
        }
        
    }
    
    
}
