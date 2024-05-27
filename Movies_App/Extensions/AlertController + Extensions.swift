//
//  AlertController + Extensions.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import UIKit

extension UIViewController {
    func showError(title: String, error: String) {
        let alertVC = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alertVC.addAction(action)
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            self.present(alertVC, animated: true)
        }
    }
}

extension UIView {
    func showError(title: String, error: String) {
        DispatchQueue.main.async { [weak self] in
            let alertVC = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alertVC.addAction(action)
            guard let self else {return}
            self.inputViewController?.present(alertVC, animated: true)
        }
    }
}

