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
    
    init(pokemonData: PokemonData) {
        self.name = pokemonData.name ?? "Unknown"
        self.type = pokemonData.types?[0].type.name ?? "Unknown"
        self.weight = String(pokemonData.weight ?? -1)
        self.height = String(pokemonData.height ?? -1)
        self.image = PokemonModel.getImage(stringUrl: pokemonData.sprites?.imageUrl)
    }
    
    static func getImage(stringUrl: String?) -> UIImage {
        let defaultImage = UIImage(named: "noImage")!
        if let string = stringUrl, let url = URL(string: string) {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                return image ?? defaultImage
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return defaultImage
    }
}
