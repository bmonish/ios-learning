## Using Generics to Build a Reusable TableView

First we are Declaring a UITableViewCell named `BaseCell` which takes in a Generic of type `U` and inherits from `UITableViewCell` Class.

```swift
class BaseCell<U>: UITableViewCell {
    var item: U!
}
```

It has a property `item` of type `U`.

Now we are defining our model for this example. We are gonna create a simple struct named `User`. It has a string property `name`.

```swift
struct User {
    let name: String
}
```

Now we are gonna reuse the `BaseCell` to create a `UserCell` which assigns the `name` property to the cell label.

```swift
class UserCell: BaseCell<User> {
    override var item: User! {
        didSet {
            textLabel?.text = item.name
        }
    }
}
```
___

Now for our UITableViewController we are defining a class `BaseTableViewController` which inherits from UITableViewController also with a generic of `<T: BaseCell<U>, U>`

```swift
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
```

It has an `items` array of type `U` which in our case will be `User`. It registers the cell we pass to it. And casts the table cell as type `BaseCell<U>`.

Now to use this complete UITableViewController we are creating a `DemoViewController` which inherits from our `BaseTableViewController` and we are just assigning the data to the `items` property.

```swift
class DemoViewController: BaseTableViewController<UserCell, User> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = [
            User(name: "John Doe"),
            User(name: "Jane Doe")
        ]
    }
    
}
```

___
