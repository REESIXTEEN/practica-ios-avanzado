//
//  Extensions.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 14/2/23.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(url: String){
        guard let url = URL(string: url) else { return }
        downloadImage(url: url) { [weak self] image in
            guard let self = self else{ return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
    }
    
    private func downloadImage(url: URL, completion: @escaping(UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
}
