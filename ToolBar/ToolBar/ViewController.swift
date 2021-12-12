//
//  ViewController.swift
//  ToolBar
//
//  Created by monish-pt4649 on 21/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    var label: UILabel!
    
    func setupView(){
        label = UILabel()
        label.textAlignment = .center
        label.text = "I'm a test label"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolBar.barStyle = UIBarStyle(rawValue: 1)!
        toolBar.isTranslucent = true
        toolBar.backgroundColor = UIColor.red
        toolBar.tintColor = UIColor.white
        toolBar.sizeToFit()
        let leftButton = UIBarButtonItem(title: "Left", style: .plain, target: self, action: #selector(tappedButton(_:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let centerButton = UIBarButtonItem(title: "Center", style: .plain, target: self, action: #selector(tappedButton(_:)))
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = 50
        let rightButton = UIBarButtonItem(title: "Right", style: .plain, target: self, action: #selector(tappedButton(_:)))
        
        // Evenly Spaced
         toolBar.setItems([leftButton, flexibleSpace, centerButton, flexibleSpace, rightButton], animated: true)
        
        // Left Aligned
         //toolBar.setItems([leftButton, centerButton, rightButton], animated: true)
        
        // Right Aligned
        //toolBar.setItems([flexibleSpace, leftButton, rightButton], animated: true)
        
        // Left & Right Corners
        //toolBar.setItems([leftButton, flexibleSpace, rightButton], animated: true)
        
        // Fixed Space
        //toolBar.setItems([fixedSpace, leftButton, flexibleSpace, rightButton, fixedSpace], animated: true)
        
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        view.addSubview(toolBar)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            toolBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    @objc
    func tappedButton(_ sender: UIBarButtonItem) {
        switch sender.title! {
        case "Left":
            label.text = "Clicked Left!"
        case "Right":
            label.text = "Clicked Right!"
        case "Center":
            label.text = "Clicked Center!"
        default:
            label.text = "I'm a test label"
        }
    }
}

