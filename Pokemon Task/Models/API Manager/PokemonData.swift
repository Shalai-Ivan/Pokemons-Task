//
//  PokemonData.swift
//  Pokemon Task
//
//  Created by MacMini on 27.10.22.
//

import Foundation

struct PokemonData: Codable {
    let nextPokemonsUrl: String
    let results: [Results]
    enum CodingKeys: String, CodingKey {
        case nextPokemonsUrl = "next"
        case results
    }
}

struct Results: Codable {
    let name: String
    let urlInfo: String
    enum CodingKeys: String, CodingKey {
        case name
        case urlInfo = "url"
    }
}

struct PokemonInfo: Codable {
    let name: String
    let sprites: [Sprites]
    let types: [TypeElement]
    let weight: Int
    let height: Int
}

struct Sprites: Codable {
    let imageUrl: String
    enum CodingKeys: String, CodingKey {
        case imageUrl = "front_default"
    }
}

struct TypeElement: Codable {
    let type: TypeType
}

struct TypeType: Codable {
    let name: String
}
