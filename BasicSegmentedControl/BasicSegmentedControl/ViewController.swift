//
//  ViewController.swift
//  BasicSegmentedControl
//
//  Created by monish-pt4649 on 17/12/21.
//

import UIKit

class ViewController: UIViewController {

    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createSegmentedControl()
    }
    
    func createSegmentedControl() {
        // Creating the ImageView
        let image = UIImage(named: "fruits.jpeg")
        imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        // Add ImageView to the View
        view.addSubview(imageView)
        
        // Constraint to center the imageView
        imageView.center = view.center
        
        // Creating the segmentedControl
        let items = ["🍎", "🍊", "🥭"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(segmentDidChange(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        // Adding SegmentedControl to View
        view.addSubview(segmentedControl)
        
        // Constraints
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            segmentedControl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 75)
        ])
    }
    
    @objc
    func segmentDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            imageView.image = UIImage(named: "apple.png")
        case 1:
            imageView.image = UIImage(named: "orange.png")
        case 2:
            imageView.image = UIImage(named: "mango.jpeg")
        default:
            imageView.image = UIImage(named: "fruits.jpeg")
        }
    }
}

