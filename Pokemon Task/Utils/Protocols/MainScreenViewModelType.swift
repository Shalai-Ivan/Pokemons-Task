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
    func getMorePokemons(completion: @escaping (Bool) -> Void)
    func getModel(forIndexPath indexPath: IndexPath, forName name: String, completion: @escaping (Pokemon) -> Void)
}
