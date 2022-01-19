//
//  TodoDetailViewController.swift
//  CombineTodo
//
//  Created by monish-pt4649 on 19/01/22.
//

import Combine
import UIKit

class TodoDetailViewController: UITableViewController {
    
    var deleteButton: UIBarButtonItem!
    var editButton: UIBarButtonItem!
    
    private var todoIndex: Int?
    private var todoTitle: String?
    private var todoNote: String?
    
    init(atIndex: Int) {
        self.todoIndex = atIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "View Todo"
        deleteButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteTodo))
        editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTodo))
        navigationItem.rightBarButtonItems = [editButton, deleteButton]
        
    }
    
    private var tokens = Set<AnyCancellable>()
    
    @objc
    func editTodo() {
        let editVC = AddTodoViewController(isEdit: true, atIndex: todoIndex)
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    @objc
    func deleteTodo() {
        print("Deleting Todo")
        NetworkingService.deleteTodo(at: todoIndex!)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (completion) in
                switch completion {
                case .finished:
                    print("Deleted")
                    self?.navigationController?.popToRootViewController(animated: true)
                case .failure(let error):
                    print("Oops", error)
                }}, receiveValue: { (todo) in
                    print("Deleted todo", todo)
                }).store(in: &tokens)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkingService.getTodo(todoIndex!)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    print("Success Detail")
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Oops", error)
                }
            }, receiveValue: { [weak self] (todo) in
                print(todo)
                self?.todoTitle = todo.title
                self?.todoNote = todo.notes
            }).store(in: &tokens)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupNavBar()
    }
}

extension TodoDetailViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Title"
        } else {
            return "Notes"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if (indexPath.section == 0) {
            cell.textLabel?.text = todoTitle ?? "Oops"
        } else {
            cell.textLabel?.text = todoNote ?? "-"
        }
        
        return cell
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.editButtonItem.isEnabled = true
    }
    
}
