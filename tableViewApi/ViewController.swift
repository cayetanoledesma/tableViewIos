//
//  ViewController.swift
//  tableViewApi
//
//  Created by Cayetano Ledesma on 9/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tablapersonajes: UITableView!
    
    @IBOutlet weak var searchpersonajes: UISearchBar!
    
    var personajeManager = FuturamaManager()
    
    var arrayPersonajes: [Personajes] = []
    
    var personajeSeleccionado: Personajes?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //registrar la nueva celda
        tablapersonajes.register(UINib(nibName: "CeldaTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        personajeManager.delegado = self
        
        tablapersonajes.delegate = self
        tablapersonajes.dataSource = self
        
        //Ejecutar el método para buscar la lista de personajes en la API
        personajeManager.verPersonaje()
        
        
    }


}

extension ViewController: futuramaManagerDelegado {
    func mostrarListaPersonajes(lista: [Personajes]) {
        arrayPersonajes = lista
        DispatchQueue.main.async {
            self.tablapersonajes.reloadData()
        }
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPersonajes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablapersonajes.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaTableViewCell
        celda.nombrePersonaje.text = arrayPersonajes[indexPath.row].character
        celda.descripcionPersonaje.text = arrayPersonajes[indexPath.row].quote
       
        if let urlString = arrayPersonajes[indexPath.row].image as? String {
            if let imagenURL = URL(string: urlString) {
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imagenURL) else
                    {return}
                    let imagen = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        celda.imagePersonaje.image = imagen
                    }
                }
            }
        }
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        personajeSeleccionado = arrayPersonajes[indexPath.row]
        
        performSegue(withIdentifier: "verPersonaje", sender: self)
        
        //Deseleccionar la tabla
        
        tablapersonajes.deselectRow(at: indexPath, animated: true)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verPersonaje" {
            let verPersonaje = segue.destination as! DetallePersonajesViewController
            verPersonaje.personajeMostrar = personajeSeleccionado
        }
    }
    
    
}

