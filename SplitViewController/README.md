## Creating a Split View Controller

```swift
let splitVC = UISplitViewController(style: .doubleColumn)
```

## Setting View Controllers

```swift
splitVC.viewControllers = [
    UINavigationController(rootViewController: menuVC),
    UINavigationController(rootViewController: secondVC)
]
```

## Output
