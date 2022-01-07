//
//  ViewController.swift
//  GenericTable
//
//  Created by monish-pt4649 on 21/01/22.
//

import UIKit

class BaseTableViewController<T: BaseCell<U>, U>: UITableViewController {
    
    let cellId = "cell"
    
    var items = [U]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(T.self, forCellReuseIdentifier: cellId)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BaseCell<U>
        cell.item = items[indexPath.row]
        return cell
    }
}

class BaseCell<U>: UITableViewCell {
    var item: U!
}

struct User {
    let name: String
}

class UserCell: BaseCell<User> {
    override var item: User! {
        didSet {
            textLabel?.text = item.name
        }
    }
}

class DemoViewController: BaseTableViewController<UserCell, User> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = [
            User(name: "John Doe"),
            User(name: "Jane Doe")
        ]
    }
    
}
