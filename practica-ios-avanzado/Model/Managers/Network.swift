//
//  Network.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 14/2/23.
//

import Foundation


enum NetworkError: Error {
    case malformedURL
    case noData
    case statusCode(code: Int?)
    case decodignFailed
    case unknown
}

final class Network {
    
    static let shared = Network()
    
    func login(email:String, password:String, completion: @escaping(String?, Error?) -> Void) {
        guard let url = URL(string: "https://dragonball.keepcoding.education//api/auth/login") else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        
        let loginString = "\(email):\(password)"
        let loginData: Data = loginString.data(using: .utf8)!
        let base64 = loginData.base64EncodedString()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data,response,error in
            
            guard error == nil else{
                completion(nil,error)
                return
            }
            
            guard let data = data else{
                completion(nil, NetworkError.noData)
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                let status = (response as? HTTPURLResponse)?.statusCode
                completion(nil, NetworkError.statusCode(code: status))
                return
            }
            
            guard let token = String(data: data, encoding: .utf8) else{
                completion(nil, NetworkError.decodignFailed)
                return
            }
            
            completion(token, nil)
            
        }
        
        task.resume()
    }
    
//    func fetchHeroes(token: String?, completion: @escaping ([Heroe]?, Error?) -> Void){
//        guard let url = URL(string: "https://dragonball.keepcoding.education//api/heros/all") else {
//            completion(nil, NetworkError.malformedURL)
//            return
//        }
//        
//        var urlComponents = URLComponents()
//        urlComponents.queryItems = [URLQueryItem(name: "name", value: "")]
//        
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "POST"
//        urlRequest.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
//        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
//        
//        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
//            guard error == nil else{
//                completion(nil,error)
//                return
//            }
//            
//            guard let data = data else{
//                completion(nil, NetworkError.noData)
//                return
//            }
//            
//            guard let heroes = try? JSONDecoder().decode([Heroe].self, from: data) else{
//                completion(nil, NetworkError.decodignFailed)
//                return
//            }
//            
//            completion(heroes, nil)
//        }
//        
//        task.resume()
//    }

    
    func getApiData() {
        
    }
}

