//
//  FuturamaManager.swift
//  tableViewApi
//
//  esta va a ser el cebrebro donde vamos a introducir toda la información de la API
//

import Foundation
import UIKit



protocol futuramaManagerDelegado {
    
    func mostrarListaPersonajes(lista: [Personajes])
}

struct FuturamaManager {
    var delegado: futuramaManagerDelegado?
    
    func verPersonaje() {
        let urlString = "https://qastusoft.com.es/apis/futurama_quotes.php"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let tarea = session.dataTask(with: url) { datos, respuest, error in
                
                if error != nil {
                    print("Error al obtener datos de la API: ", error?.localizedDescription)
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
