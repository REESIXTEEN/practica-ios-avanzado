//
//  TableViewCell.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 22/2/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellDetails: UILabel!
    @IBOutlet weak var cellName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
