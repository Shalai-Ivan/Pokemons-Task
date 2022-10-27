//
//  MainViewModel.swift
//  Pokemon Task
//
//  Created by MacMini on 27.10.22.
//

import Foundation

final class MainViewModel {
    private var names: [String]?
    private var networkManager = NetworkManager()
    private var models: [PokemonInfo] = []
    var stringUrl = "https://pokeapi.co/api/v2/pokemon"
    
    init() {
        networkManager.fetchRequest(stringUrl: stringUrl) { [weak self] names in
            self?.names = names
        }
    }
}

extension MainViewModel: MainScreenViewModelType {
    func getCount() -> Int {
        return names?.count ?? 0
    }
    func getName(forIndexpath indexPath: IndexPath) -> String {
        return names?[indexPath.row] ?? "Unknown"
    }
}
