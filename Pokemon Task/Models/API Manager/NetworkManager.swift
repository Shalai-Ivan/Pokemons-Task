//
//  APIManager.swift
//  Pokemon Task
//
//  Created by MacMini on 27.10.22.
//

import UIKit

class NetworkManager {
    var isPaginating = false
    func fetchRequest(stringUrl: String, pagination: Bool, completion: @escaping ((PokemonData) -> Void)) {
        guard let url = URL(string: stringUrl) else { return }
        if pagination {
            isPaginating = true
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 0)) {
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
                if error != nil {
                    print(error?.localizedDescription)
                }
                if let data = data {
                    if let pokemonData = self?.parseJSON(data: data) {
                        completion(pokemonData)
                        self?.isPaginating = false
                    }
                }
            }
            dataTask.resume()
        }
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
