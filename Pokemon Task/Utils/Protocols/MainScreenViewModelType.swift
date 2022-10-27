//
//  MainScreenViewModelType.swift
//  Pokemon Task
//
//  Created by MacMini on 27.10.22.
//

import Foundation

protocol MainScreenViewModelType {
    func getCount() -> Int
    func getName(forIndexpath indexPath: IndexPath) -> String
    func getModel(forIndexPath indexPath: IndexPath, completion: @escaping (PokemonData) -> Void)
}
