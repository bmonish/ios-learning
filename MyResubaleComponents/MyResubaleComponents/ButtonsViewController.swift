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
    
    func setupButton() {
        btnIcon = UIImage(systemName: "shareplay")?.withTintColor(.systemRed, renderingMode: .alwaysTemplate)
        
        button = UIButton.configureMyButton(title: "Bordered Button", textColor: .red, borderColor: .red)
        button1 = UIButton.configureMyButton(title: "Filled Button", textColor: .white, bgColor: .blue)
        
        button2 = UIButton.configureMyButton(title: "Image Icon", icon: btnIcon, textColor: .white, bgColor: .black)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Reuse Buttons"
        setupButton()
        view.addSubview(button)
        view.addSubview(button1)
        view.addSubview(button2)
        //        view.addSubview(appleIcon)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button1.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            button2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40)
            
        ])
    }
}

