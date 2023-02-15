//
//  ViewController.swift
//  collectioView
//
//  Created by estech on 2/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var personajeManager = RickAndMortyManager()
    var arrayPersonajes : [Personajes] = []
    var personajeSeleccionado: Personajes?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "CeldaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MiCelda")
        
        personajeManager.delegado = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
       
        
        personajeManager.verPersonaje()
        
        
    }


}

extension ViewController : RickAndMortyManagerDelegado, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func mostrarListaPersonajes(lista: [Personajes]) {
        arrayPersonajes = lista
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celda", for: indexPath) as! CeldaCollectionView?
        
        cell!.nombrePersonaje.text =  arrayPersonajes[indexPath.row].name
        cell!.descripcionPersonaje.text = arrayPersonajes[indexPath.row].species
        
        if let urlString = arrayPersonajes[indexPath.row].image as? String {
            if let imagenURL = URL(string: urlString) {
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imagenURL) else
                    {return}
                    let imagen = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        cell!.imagePersonaje.image = imagen
                    }
                }
            }
        }
        
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: 200 , height: 200)
        }else{
            let width = collectionView.frame.width
            return CGSize(width: (width / 2) - 8, height: width*0.5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(arrayPersonajes[indexPath.row])
        
        let alert = UIAlertController(title: "Hola", message: "Has tocado el color\(arrayPersonajes[indexPath.row])", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return arrayPersonajes.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
