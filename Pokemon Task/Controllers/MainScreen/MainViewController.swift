//
//  ViewController.swift
//  Pokemon Task
//
//  Created by MacMini on 26.10.22.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel = MainViewModel()

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
        activityIndicator.isHidden = true
    }
    private func createFooterView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        spinner.style = .large
        spinner.color = .white
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
}
// MARK: - TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.main.rawValue) as! MainTableViewCell
        cell.pokemonNameLabel.text = self.viewModel.getName(forIndexpath: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.frame.height / 20
        return height
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activityIndicator.isHidden = false
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: Identifiers.Storyboards.details.rawValue, bundle: nil)
        let detailsVC = storyboard.instantiateInitialViewController() as! DetailsViewController
        viewModel.getModel(forIndexPath: indexPath) { pokemonData in
            detailsVC.pokemonModel = PokemonModel(pokemonData: pokemonData)
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.navigationController?.pushViewController(detailsVC, animated: true)
            }
        }
    }
}
// MARK: - Pagination
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            tableView.tableFooterView = createFooterView()
            viewModel.getMorePokemons() { bool in
                if bool {
                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.tableFooterView = nil
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
}
