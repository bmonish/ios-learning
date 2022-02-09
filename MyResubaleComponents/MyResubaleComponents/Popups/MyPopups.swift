//
//  MyPopups.swift
//  MyResubaleComponents
//
//  Created by monish-pt4649 on 11/02/22.
//

import Foundation
import UIKit

extension UIAlertController {
    
    class func configureBasicAlert(title: String, message: String, preferredStyle: UIAlertController.Style = .alert, actions: [UIAlertAction] = [.init(title: "Okay", style: .default)]) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        actions.forEach { alert.addAction($0)}
        
        return alert
    }
    
    class func configureImageAlert(title: String, message: String, actions: [UIAlertAction] = [.init(title: "Okay", style: .default)]) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        
        return alert
    }
}
