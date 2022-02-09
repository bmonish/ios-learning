//
//  ButtonsViewController.swift
//  MyResubaleComponents
//
//  Created by monish-pt4649 on 08/02/22.
//

import UIKit

class ButtonsViewController: UIViewController {
    
    var button: UIButton!
    var button1: UIButton!
    var button2: UIButton!
    var btnIcon: UIImage!
    var btnIconView: UIImageView!
    
    func setupView() {
        // Setting Up Icon
        btnIcon = UIImage(systemName: "shareplay")?.withTintColor(.systemRed, renderingMode: .alwaysTemplate)
        
        // Setting up three styles of button
        button = UIButton.configureMyButton(title: "Bordered Button", textColor: .red, borderColor: .red)
        button1 = UIButton.configureMyButton(title: "Filled Button", textColor: .white, bgColor: .blue)
        button2 = UIButton.configureMyButton(title: "Image Icon", icon: btnIcon, textColor: .white, bgColor: .black)
        
        view.addSubview(button)
        view.addSubview(button1)
        view.addSubview(button2)
        
        // Custom Constraint Functions
        button.setAnchor(leading: view.leadingAnchor, centerY: view.centerYAnchor, centerPadding: -50, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: 0, height: 50))
        button1.setAnchor(leading: view.leadingAnchor, trailing: view.trailingAnchor, centerY: view.centerYAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        button2.setAnchor(leading: view.leadingAnchor, trailing: view.trailingAnchor, centerY: view.centerYAnchor, centerPadding: 40, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Reuse Buttons"
        setupView()
    }
}
