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
    var popupPage: UIButton!
    
    func setupView() {
        btnPage = UIButton.configureMyButton(title: "Go to Buttons", textColor: .red, borderColor: .red)
        segmentPage = UIButton.configureMyButton(title: "Go to Segmented Control", textColor: .blue, borderColor: .blue)
        popupPage = UIButton.configureMyButton(title: "Go to Popup Page", textColor: .green, borderColor: .green)
        btnPage.addTarget(self, action: #selector(goToButtons), for: .touchUpInside)
        segmentPage.addTarget(self, action: #selector(goToSegment), for: .touchUpInside)
        popupPage.addTarget(self, action: #selector(goToPopup), for: .touchUpInside)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [btnPage, segmentPage, popupPage].forEach { btn in
            btn?.setAnchor(size: .init(width: 300, height: 0))
            stackView.addArrangedSubview(btn!)
        }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
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
    
    @objc
    func goToPopup() {
        navigationController?.pushViewController(PopupViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationItem.title = "Reusable Components"
        setupView()
    }
    
}
