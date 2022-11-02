//
//  MainViewModel.swift
//  Pokemon Task
//
//  Created by MacMini on 27.10.22.
//

import RealmSwift
import UIKit

final class MainViewModel {
    private var nextPokemonsUrl: String = ""
    private var names: [String] = []
    private var urlsInfo: [String] = [] {
        willSet {
            self.savePokemonModel(stringUrl: newValue.last!)
        }
    }
    private var isPaginating = false
    private let apiUrl = "https://pokeapi.co/api/v2/pokemon"
    private let networkManager = NetworkManager()
    private let realm = try! Realm()
    
    init(viewController: UIViewController?) {
        networkManager.delegate = viewController as? NetworkManagerDelegate
        self.sendRequest()
    }
    private func sendRequest() {
        let stringUrl = nextPokemonsUrl.isEmpty ? apiUrl : nextPokemonsUrl
        let objects = realm.objects(PokemonsList.self)
        if objects.contains(where: { $0.currentUrl == stringUrl }) {
            let object = self.realm.object(ofType: PokemonsList.self, forPrimaryKey: stringUrl)!
            self.nextPokemonsUrl = object.nextPokemonsUrl
            for item in object.info {
                self.names.append(item.name)
                self.urlsInfo.append(item.urlInfo)
            }
        } else {
            networkManager.fetchRequest(stringUrl: stringUrl) { [weak self] pokemonData  in
                DispatchQueue.global().async {
                    try! self?.realm.write({
                        let pokemonInfo = PokemonsList(pokemonData: pokemonData, currentUrl: stringUrl)
                        self?.realm.create(PokemonsList.self, value: pokemonInfo)
                    })
                }
                self?.nextPokemonsUrl = pokemonData.nextPokemonsUrl!
                for item in pokemonData.results! {
                    self?.names.append(item.name)
                    self?.urlsInfo.append(item.urlInfo)
                }
            }
        }
    }
    private func savePokemonModel(stringUrl: String) {
        guard Reachability.isConnectedToNetwork() else { return }
        networkManager.fetchRequest(stringUrl: stringUrl) { pokemonData in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let model = Pokemon(pokemonData: pokemonData)
                let models = self.realm.objects(Pokemon.self)
                if !models.contains(where: { pokemonModel in
                    model.name == pokemonModel.name
                }) {
                    try! self.realm.write {
                        self.realm.create(Pokemon.self, value: model)
                    }
                }
            }
        }
    }
}
// MARK: - MainScreenViewModelType
extension MainViewModel: MainScreenViewModelType {

    func getCount() -> Int {
        return names.count
    }
    func getName(forIndexpath indexPath: IndexPath) -> String {
        return names[indexPath.row]
    }
    func getMorePokemons(completion: @escaping (Bool) -> Void) {
        guard !isPaginating else { return completion(false) }
        isPaginating = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.sendRequest()
            completion(true)
            self.isPaginating = false
        })
    }
    func getModel(forIndexPath indexPath: IndexPath, completion: @escaping (Pokemon) -> Void) {
        let name = names[indexPath.row]
        if let model = realm.object(ofType: Pokemon.self, forPrimaryKey: name) {
            completion(model)
        } else {
            let stringUrl = urlsInfo[indexPath.row]
            networkManager.fetchRequest(stringUrl: stringUrl) { pokemonData in
                completion(Pokemon(pokemonData: pokemonData))
            }
        }
    }
}
