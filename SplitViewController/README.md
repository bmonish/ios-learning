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
<img src="https://user-images.githubusercontent.com/31185862/147817121-3b1f0c23-de19-4cbc-bcb0-29719d7c20a8.png" height="400" />

<img src="https://user-images.githubusercontent.com/31185862/147817126-f87441de-25c4-494b-9319-984b21ef62f9.png" height="400"/>

<img src="https://user-images.githubusercontent.com/31185862/147817128-01d5a81d-f8d9-4eeb-87d4-82bbff59f4b9.png" height="400" />
