//
//  ViewController.swift
//  CombineMVVMAPITodo
//
//  Created by monish-pt4649 on 27/01/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let todoListModel = TodoListModel()
    
    var addButton: UIBarButtonItem!
    private var tableView: UITableView!
    
    fileprivate func setupNavBar() {
        navigationItem.title = "CombineMVVVM Todo"
        navigationItem.backButtonTitle = ""
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc
    func addTodo() {
        let addTodoVC = AddTodoViewController()
        addTodoVC.todoListModel = todoListModel
        navigationController?.pushViewController(addTodoVC, animated: true)
        print("Adding New Todo")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavBar()
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListModel.todos.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = todoListModel.todos.value[indexPath.row].title
        return cell
    }
    
    
}

