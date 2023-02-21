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
    case password = "password"
}

class KeyChain {
    
    func deleteData(key: keys) {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue
        ]
        
        if (SecItemDelete(query as CFDictionary)) == noErr {
            debugPrint("Data for key:\(key.rawValue) successfully deleted")
        } else {
            debugPrint("Error deleting data for key:\(key.rawValue)")
        }
    }
    
    func readData(key: keys) -> String {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            
            if let existingItem = item as? [String: Any],
               let itemData = existingItem[kSecValueData as String] as? Data,
               let data = String(data: itemData, encoding: .utf8) {
                return data
            }
            
        } else {
            debugPrint("Error reading KeyChain data for key: \(key.rawValue)")
        }
        
        return ""
        
    }
    
    func saveData(key: keys, keyValue: String) {
        
        let keyValue = keyValue.data(using: .utf8)!
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: keyValue
        ]
        
        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            debugPrint("Data with key:\(key.rawValue) saved successfully")
        } else {
            debugPrint("Error saving data with key: \(key.rawValue)")
        }
        
    }
    
    func checkKeyExists(key: keys) -> Bool  {
        let query: [String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true
        ]
        
        var item: CFTypeRef?
        
        return (SecItemCopyMatching(query as CFDictionary, &item) == noErr) ? true : false
    }
    
}
