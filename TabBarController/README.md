## Creating a Tab Bar

```swift
tabBarVc = UITabBarController()

let vc1 = UINavigationController(rootViewController: FirstViewController())
let vc2 = UINavigationController(rootViewController: SecondViewController())
let vc3 = UINavigationController(rootViewController: ThirdViewController())
let vc4 = UINavigationController(rootViewController: FourthViewController())
let vc5 = UINavigationController(rootViewController: FifthViewController())

vc1.title = "Home"
vc2.title = "Contact"
vc3.title = "About"
vc4.title = "Help"
vc5.title = "Settings"
    
tabBarVc.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: false)
```

## Setting Icons

```swift
guard let items = tabBarVc.tabBar.items else { return }
let images = ["house", "phone", "info.circle", "questionmark.circle", "gear"]
for x in 0..<items.count {
    items[x].image = UIImage(systemName: images[x])
}
```

## Output
https://user-images.githubusercontent.com/31185862/147744347-3caf3f0a-9d5a-45dc-8ecf-5f96b7250dec.mov
