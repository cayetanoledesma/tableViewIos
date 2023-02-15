//
//  CeldaCollectionView.swift
//  collectioView
//
//  Created by Jesús Fernández on 13/12/22.
//

import Foundation
import UIKit

class CeldaCollectionView: UITableViewCell {

    @IBOutlet weak var nombrePersonaje: UILabel!
    @IBOutlet weak var descripcionPersonaje: UILabel!
    @IBOutlet weak var imagePersonaje: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
