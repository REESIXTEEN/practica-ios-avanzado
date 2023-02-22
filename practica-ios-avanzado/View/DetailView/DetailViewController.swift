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
    
    var heroe: HeroeEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = heroe.name
        
        image.setImage(url: heroe.photo!)
        heroName.text = heroe.name
        heroeDescription.text = heroe.details

    }



}
