//
//  AlertService.swift
//  CombineDemoAnimals
//
//  Created by monish-pt4649 on 17/01/22.
//

import UIKit

enum AlertService {
    
    static func showAlert(with message: String, in viewController: UIViewController?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(
            .init(title: "OK", style: .cancel)
        )
        viewController?.present(alert, animated: true)
    }
}
