//
//  MyPopups.swift
//  MyResubaleComponents
//
//  Created by monish-pt4649 on 11/02/22.
//

import Foundation
import UIKit

extension UIAlertController {
    
    /**
     This method creates a Basic UIAlert Controller [Default].

     - Parameter title: A String which you want to be the alert's title.
     - Parameter message: A String which you want to be the alert's description.
     - Parameter preferredStyle (Optional): Type of UIAlertController.Style for the alert's style.
     - Parameter actions (Optional): An Array of Action of type UIAlertAction for adding actions to the alert.
     
     - Returns: an UIAlertControllers with the given title, message and actions added to it.
     */
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
