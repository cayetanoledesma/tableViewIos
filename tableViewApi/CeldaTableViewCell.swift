//
//  CeldaTableViewCell.swift
//  tableViewApi
//
//
//

import UIKit

class CeldaTableViewCell: UITableViewCell {

    @IBOutlet weak var nombrePersonaje: UILabel!
    @IBOutlet weak var descripcionPersonaje: UILabel!
    @IBOutlet weak var imagePersonaje: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imagePersonaje.layer.cornerRadius = 15
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
