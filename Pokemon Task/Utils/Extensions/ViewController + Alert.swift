//
//  ViewController + Alert.swift
//  Pokemon Task
//
//  Created by MacMini on 30.10.22.
//

import UIKit

enum AlertType {
    case error
    case internetConnection
}
extension UIViewController {
    func createAlert(fotTitle title: String, forMessage message: String, forStyle style: UIAlertController.Style, forAlertType type: AlertType, completion: ((Bool) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        switch type {
        case .error:
            let actionOk = UIAlertAction(title: "OK", style: .default) {_ in
                completion?(true)
            }
            alert.addAction(actionOk)
            self.present(alert, animated: true)
        case .internetConnection:
            let actionQuit = UIAlertAction(title: "Continue offline", style: .default) {_ in
                completion?(true)
            }
            let actionTryAgain = UIAlertAction(title: "Try again", style: .default) { action in
                completion?(false)
            }
            alert.addAction(actionQuit)
            alert.addAction(actionTryAgain)
            self.present(alert, animated: true)
        }
    }
}
