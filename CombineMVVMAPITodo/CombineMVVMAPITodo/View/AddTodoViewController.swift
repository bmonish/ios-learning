//
//  AddTodoViewController.swift
//  CombineMVVMAPITodo
//
//  Created by monish-pt4649 on 27/01/22.
//

import UIKit
import Combine

class AddTodoViewController: UIViewController {
    
    var todoListModel: TodoListModel?
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Adding Todo"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.backgroundColor = .white
    }
    
}
