//
//  KeyChain.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 20/2/23.
//

import Foundation
import Security

enum keys: String {
    case token = "token"
    case user = "user"
}

class KeyChain {
    
    func deleteData() {
        // definimos un usuario
        let username = "peter"
        
        // Preparamos la consulta
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username
        ]
        
        // ejecutamos la consulta para eliminar
        if (SecItemDelete(query as CFDictionary)) == noErr {
            debugPrint("Información del usuario eliminada con éxito")
        } else {
            debugPrint("Se produjo un error al eliminar la información del usuario")
        }
    }
    
    func updateData() {
        
        // definimos un usuario
        let username = "peter"
        let password = "jkjkjkjsd".data(using: .utf8)!
        
        // Preparamos la consulta
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username
        ]
        
        // Preparamos los atributos necesarios
        let attributes: [String: Any] = [
            kSecValueData as String: password
        ]
        
        if (SecItemUpdate(query as CFDictionary, attributes as CFDictionary)) == noErr {
            debugPrint("Información del usuario actualizada con éxito")
        } else {
            debugPrint("Se produjo un error al actualizar la información del usuario")
        }
        
    }
    
    func readData(key: keys) {
        
        // Preparamos la consulta
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            
            if let existingItem = item as? [String: Any],
               let username = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8) {
            }
            
        } else {
            debugPrint("Error reading KeyChain data for key: \(key)")
        }
        
    }
    
    func saveData(key: String, keyValue: String) {
        
        let keyValue = keyValue.data(using: .utf8)!
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: keyValue
        ]
        
        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            debugPrint("Data with key:\(key) saved successfully")
        } else {
            debugPrint("Error saving data with key: \(key)")
        }
        
    }
    
    func checkKeyExists(key:String) -> Bool  {
        let query: [String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true
        ]
        
        var item: CFTypeRef?
        
        return (SecItemCopyMatching(query as CFDictionary, &item) == noErr) ? true : false
    }
    
}
