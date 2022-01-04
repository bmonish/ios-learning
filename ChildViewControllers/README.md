## Adding a Child View Controller

```swift
func addFirstChild() {
    addChild(firstChild)
    view.addSubview(firstChild.view)
    firstChild.view.backgroundColor = .red
    firstChild.didMove(toParent: self)
    setupFirstChildConstraints()
}
```

## Output

<img src="https://user-images.githubusercontent.com/31185862/148330530-17f8395a-c839-42d0-852d-f60dd7db8710.png" width="300" />