//
//  AddTodoViewController.swift
//  CombineTodo
//
//  Created by monish-pt4649 on 18/01/22.
//

import UIKit
import Combine

class AddTodoViewController: UIViewController {
    
    var saveButton: UIBarButtonItem!
    var textField = UITextField.configureMyTextField(placeholder: "Enter Title", height: 40)
    var notesTextField: UITextView = {
        let notesTextField = UITextView()
        notesTextField.translatesAutoresizingMaskIntoConstraints = false
        notesTextField.layer.borderWidth = 0.2
        notesTextField.layer.opacity = 1
        notesTextField.layer.cornerRadius = 5
        notesTextField.text = "Enter Notes"
        notesTextField.textColor = .lightGray
        notesTextField.font = UIFont.systemFont(ofSize: 15)
        notesTextField.layer.borderColor = UIColor.gray.cgColor
        notesTextField.translatesAutoresizingMaskIntoConstraints = false
        return notesTextField
    }()
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Add Todo"
        saveButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveTodo))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    var saveTodoToken: AnyCancellable?
    
    @objc
    fileprivate func saveTodo() {
        print("Saving Todo")
        print("TextView value", notesTextField.text!)
        saveTodoToken = NetworkingService.saveTodo(title: textField.text!, notes: notesTextField.text!)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (completion) in
                switch completion {
                case .finished:
                    print("Success")
                    self?.navigationController?.popToRootViewController(animated: true)
                case .failure(let error):
                    print("Oops", error)
                }
            }, receiveValue: { (todo) in
                print("Todo Added: ", todo)
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupNavBar()
        textField.delegate = self
        self.view.addSubview(textField)
        notesTextField.delegate = self
        self.view.addSubview(notesTextField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.widthAnchor.constraint(equalToConstant: view.frame.size.width - 40),
            notesTextField.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            notesTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            notesTextField.widthAnchor.constraint(equalToConstant: view.frame.size.width - 40),
            notesTextField.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension AddTodoViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

extension AddTodoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (notesTextField.text == "Enter Notes" && notesTextField.textColor == .lightGray) {
            notesTextField.text = ""
            notesTextField.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (notesTextField.text == "") {
            notesTextField.text = "Enter Notes"
            notesTextField.textColor = .lightGray
        }
    }
}
