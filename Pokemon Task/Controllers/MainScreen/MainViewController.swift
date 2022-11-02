//
//  ViewController.swift
//  Pokemon Task
//
//  Created by MacMini on 26.10.22.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet private weak var mainTableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: MainScreenViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        viewModel = MainViewModel(viewController: self)
    }
    private func setupSettings() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)]
        title = "Choose your pokemon"
        mainTableView.delegate = self
        mainTableView.dataSource = self
        let cellNib = UINib(nibName: String(describing: MainTableViewCell.self), bundle: nil)
        mainTableView.register(cellNib, forCellReuseIdentifier: Identifiers.Cells.main.rawValue)
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
extension MainViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getCount() ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Cells.main.rawValue) as! MainTableViewCell
        cell.pokemonNameLabel.text = viewModel?.getName(forIndexpath: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.frame.height / 20
        return height
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activityIndicator.startAnimating()
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: Identifiers.Storyboards.details.rawValue, bundle: nil)
        let detailsVC = storyboard.instantiateInitialViewController() as! DetailsViewController
        viewModel?.getModel(forIndexPath: indexPath) { pokemonModel in
            detailsVC.pokemonModel = pokemonModel
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
        let scrollHeight = scrollView.contentSize.height
        if (mainTableView.contentOffset.y + scrollView.frame.size.height - 100) >= scrollHeight && (scrollHeight > 0) {
            mainTableView.tableFooterView = createFooterView()
            viewModel?.getMorePokemons() { bool in
                if bool {
                    DispatchQueue.main.async { [weak self] in
                        self?.mainTableView.tableFooterView = nil
                        self?.mainTableView.reloadData()
                    }
                }
            }
        }
    }
}
// MARK: - Network Delegate
extension MainViewController: NetworkManagerDelegate {
    func didWithError(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.createAlert(fotTitle: "Error", forMessage: error.localizedDescription,
                        forStyle: .alert, forAlertType: .error, completion: nil)
            self?.activityIndicator.stopAnimating()
        }
    }
    func updateUI() {
        DispatchQueue.main.async { [weak self] in
            self?.mainTableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
}
