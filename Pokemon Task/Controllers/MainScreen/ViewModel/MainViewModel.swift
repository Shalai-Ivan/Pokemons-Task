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
            DispatchQueue.main.sync {
                self.savePokemonModel(stringUrl: newValue.last!)                
            }
        }
    }
    private var networkManager = NetworkManager()
    private var apiUrl = "https://pokeapi.co/api/v2/pokemon"
    
    init(viewController: UIViewController) {
        networkManager.delegate = viewController as? NetworkManagerDelegate
        self.sendRequest(pagination: false, completion: nil)
    }
    private func sendRequest(pagination: Bool, completion: ((Bool) -> Void)?) {
        let stringUrl = nextPokemonsUrl.isEmpty ? apiUrl : nextPokemonsUrl
        networkManager.fetchRequest(stringUrl: stringUrl, pagination: pagination) { [weak self] pokemonData  in
            self?.nextPokemonsUrl = pokemonData.nextPokemonsUrl ?? ""
            guard let results = pokemonData.results else { return }
            for item in results {
                self?.names.append(item.name)
                self?.urlsInfo.append(item.urlInfo)
            }
            completion?(true)
        }
    }
    private func savePokemonModel(stringUrl: String) {
        networkManager.fetchRequest(stringUrl: stringUrl, pagination: false) { pokemonData in
            DispatchQueue.main.async {
                let realm = try! Realm()
                let model = Pokemon(pokemonData: pokemonData)
                let models = realm.objects(Pokemon.self)
                print("MODELS IN REALM - \(models.count)")
                if !models.contains(where: { pokemonModel in
                    model.name == pokemonModel.name
                }) {
                    print("RESUL BOOL - \(!models.contains(model))")
                    try! realm.write {
                        realm.create(Pokemon.self, value: model)
                    }
                }
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
    func getMorePokemons(completion: @escaping (Bool) -> Void) {
        guard !networkManager.isPaginating else { return completion(false) }
        sendRequest(pagination: true) { bool in
            completion(bool)
        }
    }
    func getModel(forIndexPath indexPath: IndexPath, forName name: String, completion: @escaping (Pokemon) -> Void) {
        let realm = try! Realm()
        if let model = realm.object(ofType: Pokemon.self, forPrimaryKey: name) {
            completion(model)
            print("REALM WORKED")
        } else {
            let stringUrl = urlsInfo[indexPath.row]
            networkManager.fetchRequest(stringUrl: stringUrl, pagination: false) { pokemonData in
                completion(Pokemon(pokemonData: pokemonData))
                print("NETWORK MANAGER WORKED")
            }
        }
    }
}
