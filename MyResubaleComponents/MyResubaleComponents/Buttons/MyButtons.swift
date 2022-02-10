//
//  MyFirstButton.swift
//  MyResubaleComponents
//
//  Created by monish-pt4649 on 04/02/22.
//

import Foundation
import UIKit

extension UIButton {
    
    /**
     This method creates a bordered UI Button.

     - Parameter title: String you want to add inside the button.
     - Parameter textColor: The color of the text.
     - Parameter borderColor: The color of your border.

     - Returns: an UIButton with bordered style.
     */
    class func configureMyButton(title: String, textColor: MyColors, borderColor: MyColors) -> UIButton {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = borderColor.getMyColor().cgColor
        button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        button.layer.cornerRadius = 5
        button.setTitleColor(textColor.getMyColor(), for: .normal)
        button.setTitle(title, for: .normal)
        return button
    }
    
    /**
     This method creates a filled UI Button.

     - Parameter title: String you want to add inside the button.
     - Parameter textColor: The color of the text.
     - Parameter bgColor: The color you want to fill your button with.

     - Returns: an UIButton with filled style.
     */
    class func configureMyButton(title: String, textColor: MyColors, bgColor: MyColors) -> UIButton {
        let button = UIButton()
        button.backgroundColor = bgColor.getMyColor()
        button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        button.layer.cornerRadius = 5
        button.setTitleColor(textColor.getMyColor(), for: .normal)
        button.setTitle(title, for: .normal)
        return button
    }
    
    /**
     This method creates a filled UI Button with an icon.

     - Parameter title: String you want to add inside the button.
     - Parameter icon: Icon you want to add to the button
     - Parameter textColor: The color of the text.
     - Parameter bgColor: The color you want to fill your button with.

     - Returns: an UIButton with filled style and an Icon.
     */
    class func configureMyButton(title: String, icon: UIImage, textColor: MyColors, bgColor: MyColors ) -> UIButton {
        let button = UIButton()
        button.backgroundColor = bgColor.getMyColor()
        button.layer.cornerRadius = 5
        button.setTitleColor(textColor.getMyColor(), for: .normal)
        button.setTitle(title, for: .normal)
        button.setImage(icon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 20)
        button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }
    
    
    func setAnchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, centerPadding: CGFloat? = 0, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
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
        
        if let centerY = centerY, let centerPadding = centerPadding {
            centerYAnchor.constraint(equalTo: centerY, constant: centerPadding).isActive = true
        }
        
        if (size.width != 0) {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if (size.height != 0) {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
