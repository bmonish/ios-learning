//
//  ViewController.swift
//  NavigationBar
//
//  Created by monish-pt4649 on 21/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    var searchButton: UIBarButtonItem!
    var cameraButton: UIBarButtonItem!
    var refreshButton: UIBarButtonItem!
    
    @objc
    func selectedSearch(){
      print("Searching...")
    }
    
    @objc
    func selectedCamera(){
       print("Capturing...")
    }
    
    @objc
    func selectedRefresh(){
        print("Refresh...")
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Hello"
        searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(selectedSearch))
        cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(selectedCamera))
        refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(selectedRefresh))
        navigationItem.rightBarButtonItems = [searchButton, cameraButton]
        navigationItem.leftBarButtonItem = refreshButton
        navigationController?.navigationBar.tintColor = .red
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Did load")
        // Do any additional setup after loading the view.
        setupNavBar()
    }


}

