//
//  ViewController.swift
//  BackBarButton
//
//  Created by monish-pt4649 on 21/12/21.
//

import UIKit
class ViewController: UIViewController {
    
    var button = UIButton.configureMyBackBarButton(title: "Back with Title", color: UIColor.red)
    
    @objc
    func buttonClicked() {
        print("button")
        navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    
    func setupView() {
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        navigationItem.title = NSLocalizedString("Hello", comment: "Main Screen")
        setupView()
    }
    
}

