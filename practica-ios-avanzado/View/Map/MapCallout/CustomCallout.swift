//
//  CustomCallout.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 24/2/23.
//

import Foundation
import UIKit

class CustomCallout: UIView {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var detailsBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("aaaaaaaaaaaaaaaaaaaaaaa")
    }
    
    init() {
        super.init(frame: .zero)
        print("ooooo")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
