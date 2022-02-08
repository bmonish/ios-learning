//
//  SegmentViewController.swift
//  MyResubaleComponents
//
//  Created by monish-pt4649 on 08/02/22.
//

import UIKit

class SegmentViewController: UIViewController {
    
    var segmentControl: UISegmentedControl!
    var segmentControl1: UISegmentedControl!
    var segmentControl2: UISegmentedControl!
    
    var items = ["1", "2", "3"]
    var items1 = ["Channels", "Chats", "Groups"]
    var icontItems = [
        UIImage(systemName: "folder"),
        UIImage(systemName: "tray"),
        UIImage(systemName: "trash")
    ]
    func setupSegmentControls() {
        segmentControl = UISegmentedControl.configureMySegmentedControl(items: items, action: #selector(segmentDidChange(_:)), forTarget: self)
        segmentControl1 = UISegmentedControl.configureMySegmentedControl(items: items1, action: #selector(segmentDidChange(_:)), forTarget: self)
        segmentControl2 = UISegmentedControl.configureMySegmentedControl(items: icontItems as [Any], action: #selector(segmentDidChange(_:)), forTarget: self)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(segmentControl)
        stackView.addArrangedSubview(segmentControl1)
        stackView.addArrangedSubview(segmentControl2)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
//            stackView.heightAnchor.constraint(equalToConstant: 120),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
    }
    
    @objc
    func segmentDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("0")
        case 1:
            print("1")
        case 2:
            print("2")
        default:
            print("Default")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Segment Controls"
        // Do any additional setup after loading the view.
        
        setupSegmentControls()
    }
    
}
