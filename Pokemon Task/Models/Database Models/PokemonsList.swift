//
//  PokemonsList.swift
//  Pokemon Task
//
//  Created by MacMini on 31.10.22.
//

import Foundation
import RealmSwift

class PokemonsList: Object {
    @Persisted(primaryKey: true) var currentUrl: String
    @Persisted var nextPokemonsUrl: String
    @Persisted var info: List<Info>
    convenience init(pokemonData: PokemonData, currentUrl: String) {
        self.init()
        self.currentUrl = currentUrl
        self.nextPokemonsUrl = pokemonData.nextPokemonsUrl!
        for item in pokemonData.results! {
            info.append(Info(name: item.name, urlInfo: item.urlInfo))
        }
    }
}

class Info: Object {
    @Persisted var name: String
    @Persisted var urlInfo: String
    convenience init(name: String, urlInfo: String) {
        self.init()
        self.name = name
        self.urlInfo = urlInfo
    }
}
