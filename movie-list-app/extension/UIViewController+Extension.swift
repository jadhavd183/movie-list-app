//
//  UIViewController+Extension.swift
//  movie-list-app
//
//  Created by Jadhav, Dhananjay on 06/06/24.
//

import UIKit

extension UIViewController {
    
    func showApiErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
