//
//  TableViewExtension.swift
//  Pokemon Task
//
//  Created by MacMini on 26.10.22.
//
import RealmSwift
import UIKit

extension UITableView {
    @IBInspectable var backgroundImage: UIImage? {
        get {
            return nil
        }
        set {
            backgroundView = UIImageView(image: newValue)
        }
    }
}




//
//let realm = try! Realm()
//let objects = realm.objects(PokemonData.self)
//if objects.contains(where: { $0.currentUrl == stringUrl }) {
//    let object = realm.object(ofType: PokemonData.self, forPrimaryKey: stringUrl)
//    completion(object)
//} else {
//    fetchRequest(stringUrl) { pokemonData in
//        try! realm.write({
//            pokemonData.currentUrl = stringUrl
//            realm.create(PokemonData.self, value: pokemonData)
//        })
//    }
//}
