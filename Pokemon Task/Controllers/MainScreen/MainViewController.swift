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
        self.navigationController?.isNavigationBarHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: String(describing: MainTableViewCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: Identifiers.Cells.main.rawValue)
        let headerNib = UINib(nibName: String(describing: MainTableViewHeader.self), bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: Identifiers.Headers.main.rawValue)
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Identifiers.Headers.main.rawValue) as! MainTableViewHeader
        header.initialize()
        return header
    }
}
