//
//  DetallePersonajesViewController.swift
//  tableViewApi
//
//
//

import UIKit

class DetallePersonajesViewController: UIViewController {
    
    var personajeMostrar: Personajes?
    
    @IBOutlet weak var imagePersonaje: UIImageView!
    
    @IBOutlet weak var nombrePersonaje: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePersonaje.loadFrom(URLAddres: personajeMostrar!.image)
        nombrePersonaje.text = personajeMostrar!.character
        
        imagePersonaje.layer.cornerRadius = 45
  
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

