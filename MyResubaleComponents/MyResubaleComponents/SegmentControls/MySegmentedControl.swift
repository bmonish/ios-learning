//
//  MySegmentedControl.swift
//  MyResubaleComponents
//
//  Created by monish-pt4649 on 08/02/22.
//

import Foundation
import UIKit

extension UISegmentedControl {
    
    /**
     This method creates a filled UI Segmented Control.

     - Parameter items: Array of items you want to be added to the Segmented Control..
     - Parameter action: An Action of type Selector for adding action to the Segmented Control.
     - Parameter forTarget: The ViewControl where you want the Segmented Controll's action to be.

     - Returns: an UISegmented Control with the given items and an action added to it.
     */
    class func configureMySegmentedControl(items: [Any], action: Selector, forTarget: UIViewController) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(forTarget, action: action, for: .valueChanged)
        
        return segmentedControl
        
    }
}
