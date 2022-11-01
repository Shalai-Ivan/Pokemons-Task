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
