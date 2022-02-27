//
//  TaskViewController.swift
//  TasksIOSAcademy
//
//  Created by monish-pt4649 on 03/12/21.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    var task: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Task view will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Task view appeared")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Task View will Disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Task View Did Disappear")
    }
    
    @objc func deleteTask() {
        
//        let newCount = count - 1
//
//        UserDefaults().setValue(newCount, forKey: "count")
//        UserDefaults().setValue(nil, forKey: "task_\(currentPosition)")
    }
    
}
