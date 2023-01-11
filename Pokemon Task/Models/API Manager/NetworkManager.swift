//
//  APIManager.swift
//  Pokemon Task
//
//  Created by MacMini on 27.10.22.
//

import UIKit

protocol NetworkManagerDelegate {
    func didWithError(error: Error)
    func updateUI()
}

final class NetworkManager {
    var delegate: NetworkManagerDelegate?
    func fetchRequest(stringUrl: String, completion: @escaping ((PokemonData) -> Void)) {
        guard let url = URL(string: stringUrl) else { return }
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil else {
                self?.delegate?.didWithError(error: error!)
                return
            }
            if let data = data {
                if let pokemonData = self?.parseJSON(data: data) {
                    completion(pokemonData)
                    self?.delegate?.updateUI()
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
            self.delegate?.didWithError(error: error)
        }
        return nil
    }
    
//    static func getData(stringUrl: String) -> Data {
//        if let url = URL(string: stringUrl) {
//            do {
//                let data = try Data(contentsOf: url)
//                return data
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
//        return Data()
//    }
//    static func getImage(data: Data) -> UIImage {
//        let defaultImage = UIImage(named: "noImage")!
//        let image = UIImage(data: data)
//        return image ?? defaultImage
//    }
    
    static func getImage(imageUrl: String) -> UIImage {
        let defaultImage = UIImage(named: "noImage")!
        guard let url = URL(string: imageUrl) else { return defaultImage }
        let data = try? Data(contentsOf: url)
        let image = UIImage(data: data!)
        return image ?? defaultImage
    }
}
