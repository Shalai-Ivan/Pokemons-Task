//
//  APIManager.swift
//  Pokemon Task
//
//  Created by MacMini on 27.10.22.
//

import RealmSwift
import UIKit

protocol NetworkManagerDelegate {
    func didWithError(error: Error)
    func updateUI()
}

final class NetworkManager {
    var isPaginating = false
    var delegate: NetworkManagerDelegate?
    func fetchRequest(stringUrl: String, pagination: Bool, completion: @escaping ((PokemonData) -> Void)) {
        let realm = try! Realm()
        guard let url = URL(string: stringUrl) else { return }
        if pagination {
            isPaginating = true
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 0)) {
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
                guard error == nil else {
                    self?.delegate?.didWithError(error: error!)
                    return
                }
                if let data = data {
                    if let pokemonData = self?.parseJSON(data: data) {
                        completion(pokemonData)
                        self?.isPaginating = false
                        self?.delegate?.updateUI()
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
            self.delegate?.didWithError(error: error)
        }
        return nil
    }
}
