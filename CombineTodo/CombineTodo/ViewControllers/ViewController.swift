//
//  ViewController.swift
//  CombineTodo
//
//  Created by monish-pt4649 on 18/01/22.
//

import UIKit
import Combine

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var todos = [Todo]()
    
    var addButton: UIBarButtonItem!
    private var tableView: UITableView!
    
    private var tokens = Set<AnyCancellable>()
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Combine Todo"
        navigationItem.backButtonTitle = ""
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        navigationItem.rightBarButtonItem = addButton
    }
    
    fileprivate func getTodos() {
        NetworkingService.getTodos()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    print("Todos received")
                case .failure(let error):
                    print("Oops", error)
                }
            }, receiveValue: { [weak self] (todos) in
                self?.todos = todos
                self?.tableView.reloadData()
            }).store(in: &tokens)
    }
    
    @objc
    func addTodo() {
        navigationController?.pushViewController(AddTodoViewController(isEdit: false, atIndex: nil), animated: true)
        print("Adding New Todo")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTodos()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
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
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = todos[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = TodoDetailViewController(atIndex: indexPath.row)
        navigationController?.pushViewController(detailVC, animated: true)
    }


}

