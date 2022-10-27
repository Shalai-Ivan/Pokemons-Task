//
//  PokemonModel.swift
//  Pokemon Task
//
//  Created by MacMini on 27.10.22.
//

import UIKit

struct PokemonModel {
    let name: String
    let image: UIImage
    let type: String
    let weight: String
    let height: String
    
    init(pokemonInfo: PokemonInfo) {
        self.name = pokemonInfo.name
        self.image = UIImage()
        self.type = pokemonInfo.types[0].type.name
        self.weight = String(pokemonInfo.weight)
        self.height = String(pokemonInfo.height)
    }
}
