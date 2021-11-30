//
//  SecondViewController.swift
//  BackBarButton
//
//  Created by monish-pt4649 on 21/12/21.
//

import UIKit

class SecondViewController: UIViewController {
    
    var button = UIButton.configureMyBackBarButton(title: "Back with Custom Title", color: UIColor.black)
    
    @objc
    func buttonClicked() {
        print("Button 1")
        navigationController?.pushViewController(ThirdViewController(), animated: true)
    }
    
    func setupView() {
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationItem.title = NSLocalizedString("Second", comment: "Second Screen in the App")
        navigationItem.backButtonTitle = "Custom"
        setupView()
    }
}
