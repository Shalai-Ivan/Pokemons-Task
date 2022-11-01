//
//  PokemonModel.swift
//  Pokemon Task
//
//  Created by MacMini on 27.10.22.
//

import Foundation
import RealmSwift

class Pokemon: Object {
    
    @Persisted(primaryKey: true) var name: String
    @Persisted var image: Data
    @Persisted var type: String
    @Persisted var weight: String
    @Persisted var height: String
    
    convenience init(pokemonData: PokemonData) {
        self.init()
        self.name = pokemonData.name ?? "Unknown"
        self.type = pokemonData.types?[0].type.name ?? "Unknown"
        self.weight = String(pokemonData.weight ?? -1)
        self.height = String(pokemonData.height ?? -1)
        self.image = NetworkManager.getData(stringUrl: pokemonData.sprites?.imageUrl ?? "")
    }
}
