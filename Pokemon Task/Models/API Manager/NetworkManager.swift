//
//  APIManager.swift
//  Pokemon Task
//
//  Created by MacMini on 27.10.22.
//

import UIKit

enum TypeRequest {
    case list
    case info
}

class NetworkManager {
    var nextPokemonsUrl = ""
    var completionHandler: (([PokemonModel]) -> Void)?
    func fetchRequest(stringUrl: String, completion: @escaping ((PokemonData) -> Void)) {
        guard let url = URL(string: stringUrl) else { return }
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            if let data = data {
                if let pokemonData = self?.parseJSON(data: data) {
                    completion(pokemonData)
                }
            }
        }
        dataTask.resume()
    }
    private func parseJSON (data: Data) -> PokemonData? {
        do {
            let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
            return pokemonData
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}