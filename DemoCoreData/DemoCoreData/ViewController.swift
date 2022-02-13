//
//  ViewController.swift
//  DemoCoreData
//
//  Created by monish-pt4649 on 17/02/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    private var addButton: UIBarButtonItem!
    private var tableView: UITableView!
    
    let privateContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let mainContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setupNavBar()
        setupTable()
        fetchPeople()
    }
    
    func fetchPeople() {
        
        do {
            let request = Person.fetchRequest()
            
//            let myPredicate = NSPredicate(format: "name CONTAINS 'Jac'")
//            request.predicate = myPredicate
            
            let mySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [mySortDescriptor]
            
            self.items = try mainContext.fetch(request)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        } catch (let err){
            print(err)
        }
        
    }
    
    @objc func addTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Person", message: "What is their name", preferredStyle: .alert)
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let textField = alert.textFields![0]
            
            // Creating Person Object
            let newPerson = Person(context: self.privateContext)
            newPerson.name = textField.text
            newPerson.age = 10
            newPerson.gender = "Male"
            
            // Saving the object
            do {
                try self.privateContext.save()
            }
            catch (let err) {
                print(err)
            }
            
            // Re-Fetch the data
            self.fetchPeople()
        }
        
        alert.addAction(submitButton)
        
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Basic NavBar and Table View Setup
    fileprivate func setupNavBar() {
        navigationItem.title = "Core Data"
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        navigationItem.rightBarButtonItem = addButton
    }
    
    fileprivate func setupTable() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PersonCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    // MARK: - Table View Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
        
        let person = self.items![indexPath.row]
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let person = self.items![indexPath.row]
        
        let alert = UIAlertController(title: "Edit Person", message: "Edit name", preferredStyle: .alert)
        alert.addTextField()
        
        let textField = alert.textFields![0]
        textField.text = person.name
        
        let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
            
            let textField = alert.textFields![0]
            person.name = textField.text
            
            do {
                try self.privateContext.save()
            } catch (let err) {
                print(err)
            }
            
            self.fetchPeople()
        }
        
        alert.addAction(saveButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            let personToRemove = self.items![indexPath.row]
            
            // Remove Person
            self.privateContext.delete(personToRemove)
            
            // Save Changes
            do {
                try self.privateContext.save()
            } catch (let err) {
                print(err)
            }
            
            // Re-fetch the data
            self.fetchPeople()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}

