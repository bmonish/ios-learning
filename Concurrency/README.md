## Dispatch Queues

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