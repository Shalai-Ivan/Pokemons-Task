//
//  PokemonsList.swift
//  Pokemon Task
//
//  Created by MacMini on 31.10.22.
//

import Foundation
import RealmSwift

class PokemonsList: Object {
    @Persisted(primaryKey: true) var nextList: String
    @Persisted var info: Info
}

class Info: Object {
    @Persisted var name: String
    @Persisted var urlInfo: String
}
