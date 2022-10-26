//
//  MainTableViewHeader.swift
//  Pokemon Task
//
//  Created by MacMini on 26.10.22.
//

import UIKit

final class MainTableViewHeader: UITableViewHeaderFooterView {
    @IBOutlet private weak var mainHeaderLabel: UILabel!
    func initialize() {
        mainHeaderLabel.text = "Choose your pokemon"
        mainHeaderLabel.textColor = .white
        mainHeaderLabel.textAlignment = .center
        mainHeaderLabel.backgroundColor = .clear
        mainHeaderLabel.tintColor = .clear
        mainHeaderLabel.font = UIFont.systemFont(ofSize: 25)
    }
}
