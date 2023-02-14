//
//  DetailViewController.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 14/2/23.
//

import UIKit

class DetailViewController: UIViewController {



    @IBOutlet weak var heroeDescription: UILabel!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var heroe: Heroe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = heroe.name
        
        image.setImage(url: heroe.photo)
        heroName.text = heroe.name
        heroeDescription.text = heroe.description
        
//        let token = LocalDataLayer.shared.getValue(key: .token)
//        NetworkLayer.shared.fetchTransformations(token: token, heroeId: heroe.id) { [weak self] transformations, error in
//            guard let self = self else {return}
//
//            if let transformations = transformations {
//                self.transformations = self.cleanTranformations(transformations)
//
//                if !self.transformations.isEmpty {
//                    DispatchQueue.main.async {
//                        self.transformacionesButton.alpha = 1
//                    }
//                }
//
//            }else{
//                print("Error fetching transformations :", error?.localizedDescription ?? "")
//            }
//
//        }
        

        
    }



}
