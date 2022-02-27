//
//  ViewController.swift
//  NoStoryBoard
//
//  Created by monish-pt4649 on 30/11/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .gray
        view.addSubview(imageView)
        
        // constraints
        let constraints = [
            imageView.centerXAnchor.constraint(equalTo:  view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 350),
            imageView.heightAnchor.constraint(equalToConstant: 450)
        ]
        // activating the constraint
        NSLayoutConstraint.activate(constraints)
    }
    
    // Image view
    lazy var imageView: UIImageView = {
        let image = UIImage(named: "Image.png")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
}

