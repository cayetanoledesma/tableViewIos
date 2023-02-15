//
//  DetallePersonajesViewController.swift
//  collectioView
//
//  Created by Jesús Fernández on 13/12/22.
//

import Foundation
import UIKit

class DetallePersonajesViewController: UICollectionViewCell {
    
    var personajeMostrar: Personajes?
    
    @IBOutlet weak var imagePersonaje: UIImageView!
    
    @IBOutlet weak var nombrePersonaje: UILabel!
    
    
     func viewDidLoad() {
    viewDidLoad()
        imagePersonaje.loadFrom(URLAddres: personajeMostrar!.image)
        nombrePersonaje.text = personajeMostrar!.name
        

  
    }

}

extension UIImageView {
    func loadFrom(URLAddres: String) {
        guard let url = URL(string: URLAddres) else {return}
        DispatchQueue.main.async { [weak self] in
            if let imagenData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imagenData){
                    self?.image = loadedImage
                }
            }
        }
    }
}
