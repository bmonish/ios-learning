//
//  ViewController.swift
//  ChildViewControllers
//
//  Created by monish-pt4649 on 31/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    let firstChild = FirstChild()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        addFirstChild()
    }
    
    func addFirstChild() {
        addChild(firstChild)
        view.addSubview(firstChild.view)
        firstChild.view.backgroundColor = .red
        firstChild.didMove(toParent: self)
        setupFirstChildConstraints()
    }
    
    func setupFirstChildConstraints() {
        firstChild.view.translatesAutoresizingMaskIntoConstraints = false
        firstChild.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        firstChild.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        firstChild.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        firstChild.view.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSecondChild" {
            let destVC = segue.destination as! SecondChild
            destVC.view.backgroundColor = .blue
        }
    }
    
}

