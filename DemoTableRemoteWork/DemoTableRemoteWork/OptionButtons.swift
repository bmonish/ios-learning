//
//  OptionButtons.swift
//  DemoTableRemoteWork
//
//  Created by monish-pt4649 on 04/03/22.
//

import UIKit

extension UIButton {
    class func configureOptionButton() -> UIButton{
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
