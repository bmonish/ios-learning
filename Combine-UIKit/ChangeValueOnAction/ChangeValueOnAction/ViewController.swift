//
//  ViewController.swift
//  ChangeValueOnAction
//
//  Created by monish-pt4649 on 20/01/22.
//

import UIKit
import Combine

extension Notification.Name {
    static let newBlogPost = Notification.Name("newPost")
}

struct BlogPost {
    let title: String
}

class ViewController: UIViewController {
    
    var blogTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Enter text"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var publishButton: UIButton = {
        var button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Publish", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var textLabel: UILabel = {
        var label = UILabel()
        label.text = "Default"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    func setupView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(blogTextField)
        stackView.addArrangedSubview(publishButton)
        stackView.addArrangedSubview(textLabel)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            blogTextField.widthAnchor.constraint(equalToConstant: 200),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalToConstant: 120),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        
        publishButton.addTarget(self, action: #selector(publishButtonTapped), for: .primaryActionTriggered)
        
        // Creating a Publisher
        let publisher = NotificationCenter.Publisher(center: .default, name: .newBlogPost, object: nil)
            .map { (notification) -> String? in
                return (notification.object as? BlogPost)?.title ?? ""
            }
        
        // Creating a subscriber
        let subscriber = Subscribers.Assign(object: textLabel, keyPath: \.text)
        publisher.subscribe(subscriber)
    }
    
    @objc
    func publishButtonTapped(_ sender: UIButton) {
        let title = blogTextField.text ?? "Coming Soon"
        let blogPost = BlogPost(title: title)
        NotificationCenter.default.post(name: .newBlogPost, object: blogPost)
    }
    
    
}

