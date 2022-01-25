//
//  ViewController.swift
//  TodoApp
//
//  Created by Karin Prater on 04.02.21.
//

import UIKit
import Combine

class TodoListViewController: UIViewController {

    // use viewmodel to populate table
    let taskViewModel = TaskListModel()
    
    // To Fix the @Publisher Delay
    var tasks = ["Milk"]
    
    @IBOutlet weak var tableView: UITableView!
    
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        // add data stream that calls tableView.reloadData() when data changes
        taskViewModel.$tasks.sink { [unowned self] values in
            print("Receive Values \(values)")
            print("Table is reloading data with \(self.taskViewModel.tasks)")
            self.tasks = values
            self.tableView.reloadData()
        }.store(in: &subscriptions)
    }

    @IBSegueAction func addNewViewIsGoingToAppear(_ coder: NSCoder) -> AddNewViewController? {
        let controller = AddNewViewController(coder: coder)
        // hande over viewmodel to controller
        controller?.taskListModel = taskViewModel
        return controller
    }
    
}

extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    
}
