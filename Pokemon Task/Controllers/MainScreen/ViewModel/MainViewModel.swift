//
//  MainViewModel.swift
//  Pokemon Task
//
//  Created by MacMini on 27.10.22.
//

import Foundation

final class MainViewModel {
    private var nextPokemonsUrl: String?
    private var names: [String] = []
    private var urlsInfo: [String] = []
    private var networkManager = NetworkManager()
    var stringUrl = "https://pokeapi.co/api/v2/pokemon"
    
    init() {
        networkManager.fetchRequest(stringUrl: stringUrl) { [weak self] pokemonData in
            self?.nextPokemonsUrl = pokemonData.nextPokemonsUrl
            guard let results = pokemonData.results else { return }
            for item in results {
                self?.names.append(item.name)
                self?.urlsInfo.append(item.urlInfo)
            }
        }
    }
}

extension MainViewModel: MainScreenViewModelType {

    func getCount() -> Int {
        return names.count
    }
    func getName(forIndexpath indexPath: IndexPath) -> String {
        return names[indexPath.row]
    }
    func getModel(forIndexPath indexPath: IndexPath, completion: @escaping (PokemonData) -> Void) {
        let stringUrl = urlsInfo[indexPath.row]
        networkManager.fetchRequest(stringUrl: stringUrl) { pokemonData in
            completion(pokemonData)
        }
    }
}
