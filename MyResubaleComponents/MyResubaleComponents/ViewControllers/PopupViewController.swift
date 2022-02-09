//
//  PopupViewController.swift
//  MyResubaleComponents
//
//  Created by monish-pt4649 on 11/02/22.
//

import UIKit

class PopupViewController: UIViewController {

    var basicDefaultPopupBtn: UIButton!
    lazy var basicDefaultAlert: UIAlertController! = {
        let basicDefaultAlert = UIAlertController.configureBasicAlert(title: "Default Popup",
                                                               message: "This is how a default popup with one action will be shown")
        
        return basicDefaultAlert
    }()
    
    var customActionPopupBtn: UIButton!
    lazy var customActionAlert: UIAlertController! = {
        let customActionAlert = UIAlertController.configureBasicAlert(title: "Custom Actions", message: "This popup has custom actions and it will be displayed like this", actions: [.init(title: "Custom Action 1", style: .default), .init(title: "Custom Action 2", style: .destructive), .init(title: "Custom Action 3", style: .cancel)])
        
        return customActionAlert
    }()
    
    var popupWithImageBtn: UIButton!
    lazy var imageAlert: UIAlertController! = {
        let imageAlert = UIAlertController.configureImageAlert(title: "Image Alert", message: "This is a image alert")
        
        return imageAlert
    }()
    
    func setupView() {
        basicDefaultPopupBtn = UIButton.configureMyButton(title: "Show Basic Popup", textColor: .green, borderColor: .green)
        customActionPopupBtn = UIButton.configureMyButton(title: "Show Custom Action Popup", textColor: .red, borderColor: .red)
        popupWithImageBtn = UIButton.configureMyButton(title: "Show Image Popup", textColor: .blue, borderColor: .blue)
        basicDefaultPopupBtn.addTarget(self, action: #selector(showBasicPopup), for: .touchUpInside)
        customActionPopupBtn.addTarget(self, action: #selector(showCustomActionPopup), for: .touchUpInside)
        popupWithImageBtn.addTarget(self, action: #selector(showImagePopup), for: .touchUpInside)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [basicDefaultPopupBtn, customActionPopupBtn, popupWithImageBtn].forEach { btn in
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Popup Page"
        
        setupView()
    }

    @objc
    func showBasicPopup() {
        self.present(basicDefaultAlert, animated: true)
    }
    
    @objc
    func showCustomActionPopup() {
        self.present(customActionAlert, animated: true)
    }
    
    @objc
    func showImagePopup() {
        self.present(imageAlert, animated: true)
    }
}
