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
     This method creates a filled UI Segmented Control [Default].

     - Parameter items: Array of items you want to be added to the Segmented Control..
     - Parameter action: An Action of type Selector for adding action to the Segmented Control.
     - Parameter forTarget: The ViewControl where you want the Segmented Controll's action to be.

     - Returns: an UISegmented Control with the given items and an action added to it.
     */
    class func configureMySegmentedControl(items: [Any], action: Selector, forTarget: Any?) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(forTarget, action: action, for: .valueChanged)
        return segmentedControl
    }
    
    /**
     This method creates a filled UI Segmented Control with custom colors.

     - Parameter items: Array of items you want to be added to the Segmented Control..
     - Parameter action: An Action of type Selector for adding action to the Segmented Control.
     - Parameter forTarget: The ViewControl where you want the Segmented Controll's action to be.
     - Parameter borderColor: The Color which you want the borders to have.
     - Parameter tintColor: The Color which you want the tint to be.

     - Returns: an UISegmented Control with the given items and an action added to it.
     */
    class func configureMySegmentedControl(items: [Any], action: Selector, forTarget: Any?, borderColor: MyColors, tintColor: MyColors) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(forTarget, action: action, for: .valueChanged)
        segmentedControl.layer.masksToBounds = true
        segmentedControl.layer.borderColor = borderColor.getMyColor().cgColor
        segmentedControl.selectedSegmentTintColor = tintColor.getMyColor()
        segmentedControl.layer.borderWidth = 1
        return segmentedControl
    }
    
    func setAnchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if (size.width != 0) {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if (size.height != 0) {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
