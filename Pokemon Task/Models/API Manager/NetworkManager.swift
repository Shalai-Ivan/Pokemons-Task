//
//  APIManager.swift
//  Pokemon Task
//
//  Created by MacMini on 27.10.22.
//

import UIKit

//enum TypeRequest {
//    case list(stringUrl: String)
//    case info(stringUrl: String)
//}

class NetworkManager {
    var nextPokemonsUrl = ""
    var completionHandler: (([PokemonModel]) -> Void)?
    func fetchRequest(stringUrl: String, completion: @escaping (([String]) -> Void)) {
        guard let url = URL(string: stringUrl) else { return }
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            if let data = data {
                if let names = self?.parseJSON(data: data) {
                    completion(names)
                }
            }
        }
        dataTask.resume()
    }
    private func parseJSON (data: Data) -> [String]? {
        do {
            let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
            let pokemonModels = pokemonData.results.map { $0.name }
            return pokemonModels
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}
