//
//  ViewController.swift
//  ComplexPublishersExample
//
//  Created by monish-pt4649 on 21/01/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var nameTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Enter name"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var passwordAgainTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Enter password again"
        textField.isSecureTextEntry = true
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var signUpButton: UIButton = {
        var button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Sign Up", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupView() {
        navigationItem.title = "Sign Up Page"
        view.backgroundColor = .white
        
        let stackView =  UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordAgainTextField)
        stackView.addArrangedSubview(signUpButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            nameTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordAgainTextField.widthAnchor.constraint(equalToConstant: 300),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
        
        nameTextField.delegate = self
        passwordTextField.delegate = self
        passwordAgainTextField.delegate = self
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped(_:)), for: .primaryActionTriggered)
    }
    
    // Step 1: Define our publishers
    @Published var password = ""
    @Published var passwordAgain = ""
    @Published var username: String = ""
    
    // Step 2: Define our validation streams
    var validatedUsername: AnyPublisher<String?, Never> {
        return $username
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { username in
                return Future { promise in
                    self.usernameAvailable(username) { available in
                        promise(.success(available ? username : nil))
                    }
                }
            }
            .eraseToAnyPublisher()
    }
    
    func usernameAvailable(_ username: String, completion: (Bool) -> Void) {
        completion(true) // Our fake asynchronous backend service
    }
    
    var validatedPassword: AnyPublisher<String?, Never> {
        return Publishers.CombineLatest($password, $passwordAgain)
            .map { password, passwordRepeat in
                guard password == passwordRepeat, password.count > 0 else { return nil }
                return password
            }
            .map {
                ($0 ?? "") == "password1" ? nil : $0
            }
            .eraseToAnyPublisher()
    }
    
    var validatedCredentials: AnyPublisher<(String, String)?, Never> {
        return Publishers.CombineLatest(validatedUsername, validatedPassword)
            .receive(on: RunLoop.main)
            .map { username, password in
                guard let uname = username, let pwd = password else { return nil }
                return (uname, pwd)
            }
            .eraseToAnyPublisher()
    }
    
    // Step 3: Define our subscriber
    var signUpButtonSubscriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        
        // Step 4: Hook our subscriber up to our validation publisher stream
        signUpButtonSubscriber = validatedCredentials
            .map { $0 != nil }
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: signUpButton)
        
        if(signUpButton.isEnabled == false) {
            signUpButton.layer.borderColor = UIColor.red.cgColor
        } else {
            signUpButton.layer.borderColor = UIColor.black.cgColor
        }
        
    }
    
    @objc private func signUpButtonTapped(_ sender: UIButton) {
        print("SignUp button enabled!")
        AlertService.showAlert(with: "Signed Up", in: self)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText = textField.text ?? ""
        let text = (textFieldText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == nameTextField { username = text }
        if textField == passwordTextField { password = text }
        if textField == passwordAgainTextField { passwordAgain = text }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
