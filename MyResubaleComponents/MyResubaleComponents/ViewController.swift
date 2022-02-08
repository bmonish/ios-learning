//
//  ViewController.swift
//  MyResubaleComponents
//
//  Created by monish-pt4649 on 04/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    var btnPage: UIButton!
    var segmentPage: UIButton!
    
    func setupView() {
        btnPage = UIButton.configureMyButton(title: "Go to Buttons", textColor: .red, borderColor: .red)
        segmentPage = UIButton.configureMyButton(title: "Go to Segmented Control", textColor: .blue, borderColor: .blue)
        btnPage.addTarget(self, action: #selector(goToButtons), for: .touchUpInside)
        segmentPage.addTarget(self, action: #selector(goToSegment), for: .touchUpInside)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(btnPage)
        stackView.addArrangedSubview(segmentPage)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            btnPage.widthAnchor.constraint(equalToConstant: 300),
            segmentPage.widthAnchor.constraint(equalToConstant: 300), 
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalToConstant: 120),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
    }
    
    @objc
    func goToButtons() {
        navigationController?.pushViewController(ButtonsViewController(), animated: true)
    }
    
    @objc
    func goToSegment() {
        navigationController?.pushViewController(SegmentViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationItem.title = "Reusable Components"
        setupView()
    }
    
}
