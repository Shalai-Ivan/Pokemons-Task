//
//  LaunchViewController.swift
//  Pokemon Task
//
//  Created by MacMini on 31.10.22.
//

import UIKit

class SplashViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async { [weak self] in
            self?.internetCheck()
        }
    }
    // Checking internet connection
    @objc private func internetCheck() {
        if !Reachability.isConnectedToNetwork() {
            createAlert(fotTitle: "Bad connection", forMessage: "Sorry, you have no internet connection",
                        forStyle: .alert, forAlertType: .internetConnection) { [weak self] bool in
                if bool {
                    self?.performSegue(withIdentifier: Identifiers.Segues.main.rawValue, sender: nil)
                } else {
                    self?.activityIndicator.startAnimating()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self?.internetCheck()
                        self?.activityIndicator.stopAnimating()
                    }
                }
            }
        } else {
            performSegue(withIdentifier: Identifiers.Segues.main.rawValue, sender: nil)
        }
    }
}
