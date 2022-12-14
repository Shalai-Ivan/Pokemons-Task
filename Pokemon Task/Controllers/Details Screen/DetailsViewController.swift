//
//  DetailsViewController.swift
//  Pokemon Task
//
//  Created by MacMini on 26.10.22.
//

import UIKit

final class DetailsViewController: UIViewController {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var pokemonImage: UIImageView!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var heightLabel: UILabel!
    var pokemonModel: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        guard let pokemonModel = pokemonModel else {
            createAlert(fotTitle: "Error", forMessage: "Sorry, something went wrong.", forStyle: .alert, forAlertType: .error) { [weak self] _ in
                self?.navigationController?.popToRootViewController(animated: true)
            }
            return }
        self.nameLabel.text = pokemonModel.name
        self.pokemonImage.image = NetworkManager.getImage(imageUrl: pokemonModel.image)
        self.typeLabel.text = "Type: \(pokemonModel.type)"
        self.weightLabel.text = "Weight: \(pokemonModel.weight)kg"
        self.heightLabel.text = "Height: \(pokemonModel.height)cm"
    }
}
