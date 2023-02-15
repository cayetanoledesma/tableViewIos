//
//  RickAndMortyManager.swift
//  collectioView
//
//  Created by Jesús Fernández on 13/12/22.
//

import Foundation
import UIKit

protocol RickAndMortyManagerDelegado {
    func mostrarListaPersonajes(lista: [Personajes])
}

struct RickAndMortyManager {
    var delegado: RickAndMortyManagerDelegado?
    
    func verPersonaje(){
        let urlString = "https://rickandmortyapi.com/api"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let tarea = session.dataTask(with: url) {
                datos, respuesta, error in
                
                if error != nil {
                    print("Error al obtener datos de la API")
                }
                
                if let datosSeguros = datos?.parseData(quitarString: "null,") {
                    if let listaPersonajes = self.parsearJSON(datosPersonajes: datosSeguros) {
                        print("Lista personajes: ", listaPersonajes)
                        delegado?.mostrarListaPersonajes(lista: listaPersonajes)
                    }
                }
            }
            tarea.resume()
        }
    }
    func parsearJSON(datosPersonajes: Data) -> [Personajes]? {
        let decodificador = JSONDecoder()
        do {
            let datosDecodificados = try decodificador.decode([Personajes].self, from: datosPersonajes)
            return datosDecodificados
        }catch {
            print("Error al decodificar los datos: ", error.localizedDescription)
            return nil
        }
    }
}

extension Data {
    func parseData(quitarString palabra: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: palabra, with: "")
        
        guard let data = parseDataString?.data(using: .utf8) else {return nil}
        return data
    }
}
