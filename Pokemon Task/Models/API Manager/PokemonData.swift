//
//  PokemonData.swift
//  Pokemon Task
//
//  Created by MacMini on 27.10.22.
//

import Foundation
import RealmSwift

struct PokemonData: Codable {
    let nextPokemonsUrl: String?
    let results: [Results]?
    let name: String?
    let sprites: Sprites?
    let types: [TypeElement]?
    let weight: Int?
    let height: Int?
    enum CodingKeys: String, CodingKey {
        case nextPokemonsUrl = "next"
        case results, name, sprites, types, weight, height
    }
}

struct Results: Codable {
    var name: String
    var urlInfo: String
    enum CodingKeys: String, CodingKey {
        case name
        case urlInfo = "url"
    }
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
