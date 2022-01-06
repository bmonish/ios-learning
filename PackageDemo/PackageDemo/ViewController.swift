//
//  ViewController.swift
//  PackageDemo
//
//  Created by monish-pt4649 on 12/01/22.
//

import UIKit
import MonishPackage

class ViewController: UIViewController {
    
    // Button method from Package
    var button = UIButton.configureMyBackBarButton(title: "Back with Title", color: UIColor.red)
    
    @objc
    func buttonClicked() {
        print("button")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
}

