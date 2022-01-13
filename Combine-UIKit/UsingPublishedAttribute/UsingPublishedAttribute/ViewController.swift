//
//  ViewController.swift
//  UsingPublishedAttribute
//
//  Created by monish-pt4649 on 20/01/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var termsLabel: UILabel = {
        var label = UILabel()
        label.text = "Terms & Condition"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    var termsSwitch: UISwitch = {
        var termsSwitch = UISwitch()
        termsSwitch.translatesAutoresizingMaskIntoConstraints = false
        return termsSwitch
    }()
    
    var privacyLabel: UILabel = {
        var label = UILabel()
        label.text = "Privacy Policy"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    var privacySwitch: UISwitch = {
        var privacySwitch = UISwitch()
        privacySwitch.translatesAutoresizingMaskIntoConstraints = false
        return privacySwitch
    }()
    
    var nameTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Enter name"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var saveButton: UIButton = {
        var button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Submit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupView() {
        let stackView1 = UIStackView()
        stackView1.axis = .horizontal
        stackView1.distribution = .fillEqually
        stackView1.alignment = .center
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        stackView1.addArrangedSubview(termsLabel)
        stackView1.addArrangedSubview(termsSwitch)
        
        let stackView2 = UIStackView()
        stackView2.axis = .horizontal
        stackView2.distribution = .fillEqually
        stackView2.alignment = .center
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView2.addArrangedSubview(privacyLabel)
        stackView2.addArrangedSubview(privacySwitch)
        
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.alignment = .center
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addArrangedSubview(stackView1)
        mainStackView.addArrangedSubview(stackView2)
        mainStackView.addArrangedSubview(nameTextField)
        mainStackView.addArrangedSubview(saveButton)
        
        view.addSubview(mainStackView)
        
        termsSwitch.addTarget(self, action: #selector(acceptTerms), for: .valueChanged)
        privacySwitch.addTarget(self, action: #selector(acceptPrivacy), for: .valueChanged)
        nameTextField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
        
        saveButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            stackView1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            stackView1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            stackView2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            stackView2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            nameTextField.widthAnchor.constraint(equalToConstant: 300),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            mainStackView.heightAnchor.constraint(equalToConstant: 250),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
    }
    
    @Published private var acceptedTerms = false
    @Published private var acceptedPrivacy = false
    @Published private var name = ""
    
    private var validToSubmit: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest3($acceptedTerms, $acceptedPrivacy, $name)
            .map { terms, privacy, name in
                return terms && privacy && !name.isEmpty
            }.eraseToAnyPublisher()
    }
    
    private var buttonSubscriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        nameTextField.delegate = self
        
        buttonSubscriber = validToSubmit
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: saveButton)
    }
    
    @objc
    func acceptTerms(_ sender: UISwitch) {
        acceptedTerms = sender.isOn
    }
    
    @objc
    func acceptPrivacy(_ sender: UISwitch) {
        acceptedPrivacy = sender.isOn
    }
    
    @objc
    func nameChanged(_ sender: UITextField) {
        name = sender.text ?? ""
    }
    
    @objc
    func submitAction(_ sender: UIButton) {
        print("Button Enabled")
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
