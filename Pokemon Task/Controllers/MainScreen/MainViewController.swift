//
//  ViewController.swift
//  Pokemon Task
//
//  Created by MacMini on 26.10.22.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
    }
    private func setupSettings() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)]
        title = "Choose your pokemon"
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: String(describing: MainTableViewCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: Identifiers.Cells.main.rawValue)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.main.rawValue) as! MainTableViewCell
        cell.pokemonNameLabel.text = "pokemon"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.frame.height / 20
        return height
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: Identifiers.Storyboards.details.rawValue, bundle: nil)
        let detailsVC = storyboard.instantiateInitialViewController() as! DetailsViewController
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
