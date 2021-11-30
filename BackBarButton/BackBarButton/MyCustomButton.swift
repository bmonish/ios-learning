//
//  MyCustomButton.swift
//  BackBarButton
//
//  Created by monish-pt4649 on 21/12/21.
//

import UIKit

extension UIButton {
    class func configureMyBackBarButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = color.cgColor
        button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        button.layer.cornerRadius = 5
        button.setTitleColor(color, for: .normal)
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
