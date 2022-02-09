//
//  SegmentViewController.swift
//  MyResubaleComponents
//
//  Created by monish-pt4649 on 08/02/22.
//

import UIKit

class SegmentViewController: UIViewController {

    var segmentControl1: UISegmentedControl!
    var segmentControl2: UISegmentedControl!
    var segmentControl3: UISegmentedControl!
    
    
    var items1 = ["Channels", "Chats", "Groups"]
    var icontItems = [
        UIImage(systemName: "folder"),
        UIImage(systemName: "tray"),
        UIImage(systemName: "trash")
    ]
    var items2 = ["1", "2", "3"]
    
    func setupSegmentControls() {
        segmentControl1 = UISegmentedControl.configureMySegmentedControl(items: items1, action: #selector(segmentDidChange(_:)), forTarget: self)
        segmentControl2 = UISegmentedControl.configureMySegmentedControl(items: icontItems as [Any], action: #selector(segmentDidChange(_:)), forTarget: self)
        segmentControl3 = UISegmentedControl.configureMySegmentedControl(items: items2, action: #selector(segmentDidChange(_:)), forTarget: self, borderColor: .red, tintColor: .green)

        
        [segmentControl1, segmentControl2, segmentControl3].forEach { view.addSubview($0) }
        
        segmentControl1.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        segmentControl2.setAnchor(top: segmentControl1.bottomAnchor, leading: view.leadingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        segmentControl3.setAnchor(top: segmentControl2.bottomAnchor, leading: view.leadingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 0))
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
