# Dispatch Queues

An object that manages the execution of tasks serially or concurrently on your app's main thread or on a background thread.

```swift
func getData() {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/1") else { return }

    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      guard data != nil else { return }

      self?.view.backgroundColor = .red
    }
    task.resume()
}
```

This above code will thrown a warning because the UI updates should be run on the main thread. To fix this, we can use a DispatchQueue.

```swift
DispatchQueue.main.async {
    self?.view.backgroundColor = .red
}
```

To run a task on a background thread, we can use the DispatchQueue.global() function.

```swift
DispatchQueue.global(qos: .background).async {
    self?.getData()
}
```

`.background` is here of type QoS Class. The default Qos Classes that are available are:

- `userInteractive` - The quality-of-service class for user-interactive tasks, such as animations, event handling, or updating your app's user interface.
- `userInitiated` - The quality-of-service class for tasks that prevent the user from actively using your app.
- `utility` - The quality-of-service class for tasks that the user does not track actively.
- `background` - The quality-of-service class for maintenance or cleanup tasks that you create.
- `unspecified` - The absence of a quality-of-service class.

---

# Dispatch Groups

A `group of tasks` that you `monitor` as a single unit.

Groups allow you to `aggregate a set of tasks` and synchronize behaviors on the group. You attach multiple work items to a group and schedule them for asynchronous execution on the same queue or different queues. When all work items finish executing, the group executes its completion handler. You can also wait synchronously for all tasks in the group to finish executing.

Creating a DispatchGroup

```swift
let group = DispatchGroup()
```

Notifying the group that we are entering some work

```swift
group.enter()
```

And notifying the group when we are done with some work (leaving).

```
group.leave()
```

Simple Example:

```swift
import UIKit

func getData() {
    let urls = [
        "https://api.google.com/1",
        "https://api.google.com/2",
        "https://api.google.com/3",
    ]

    let group = DispatchGroup()

    for url in urls {

        guard let url = URL(string: url) else { continue }

        group.enter()
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            defer {
                group.leave()
            }

            guard let data = data else { return }
            print(data)
        })

        task.resume()
    }

    group.notify(queue: .main, execute: {
        print("Group Done")
    })
}

getData()
```

Another Example: [DispatchGroup in App](https://github.com/bmonish/ios-learning/blob/master/Concurrency/DispatchGroups/DispatchGroups/ViewController.swift)

---

# Concurrency

## Serial

The previous task must be completed inorder for the next task to begin.

```swift
let queue = DispatchQueue(label: "bmonish.queue")

queue.async {
    print("Begin: Task 1")
    print("End: Task 1")
}

queue.async {
    print("Begin: Task 2")
    print("End: Task 2")
}
```

Here the first task is executed first and then the second task is executed only after first is completed.

Output:

```
Begin: Task 1
End: Task 1
Begin: Task 2
End: Task 2
```

## Concurrent

It can run tasks concurrently even though the previous tasks hasn't been completed yet,

```swift
let queue = DispatchQueue(label: "bmonish.queue", attributes: .concurrent)

queue.async {
    print("Begin: Task 1")
    print("End: Task 1")
}

queue.async {
    print("Begin: Task 2")
    print("End: Task 2")
}
```

Here the output will be: (Although it isn't mandatory that the tasks will end in the same order they have started.)

```
Begin: Task 1
Begin: Task 2
End: Task 1
End: Task 2
```

But when the concurrent queues have `synchronous` block they will be executed similar to serial queues.

```swift
let queue = DispatchQueue(label: "bmonish.queue", attributes: .concurrent)

queue.sync {
    print("Begin: Task 1")
    print("End: Task 1")
}

queue.sync {
    print("Begin: Task 2")
    print("End: Task 2")
}
```
