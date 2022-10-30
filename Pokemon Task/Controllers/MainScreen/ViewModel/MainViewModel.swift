//
//  MainViewModel.swift
//  Pokemon Task
//
//  Created by MacMini on 27.10.22.
//

import Foundation

final class MainViewModel {
    private var nextPokemonsUrl: String = ""
    private var names: [String] = []
    private var urlsInfo: [String] = []
    private var networkManager = NetworkManager()
    var apiUrl = "https://pokeapi.co/api/v2/pokemon"
    
    init() {
        sendRequest(pagination: false, completion: nil)
    }
    private func sendRequest(pagination: Bool, completion: ((Bool?, String?) -> Void)?) {
        let stringUrl = nextPokemonsUrl.isEmpty ? apiUrl : nextPokemonsUrl
        networkManager.fetchRequest(stringUrl: stringUrl, pagination: pagination) { [weak self] pokemonData, error  in
            guard error == nil else {
                completion?(false, error)
                return
            }
            self?.nextPokemonsUrl = pokemonData?.nextPokemonsUrl ?? ""
            guard let results = pokemonData?.results else { return }
            for item in results {
                self?.names.append(item.name)
                self?.urlsInfo.append(item.urlInfo)
            }
            completion?(true, nil)
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
    func getMorePokemons(completion: @escaping (Bool) -> Void) {
        guard !networkManager.isPaginating else { return completion(false) }
        sendRequest(pagination: true) { bool, error in
            guard let bool = bool else { return }
            completion(bool)
        }
    }
    func getModel(forIndexPath indexPath: IndexPath, completion: @escaping (PokemonData) -> Void) {
        let stringUrl = urlsInfo[indexPath.row]
        networkManager.fetchRequest(stringUrl: stringUrl, pagination: false) { pokemonData, error  in
            guard let pokemonData = pokemonData else { return }
            completion(pokemonData)
        }
    }
}
