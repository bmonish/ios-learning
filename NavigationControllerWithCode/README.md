## Scene Delegate

```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window?.windowScene = windowScene
    window?.makeKeyAndVisible()
    let controller = ViewController()
    let navController = UINavigationController(rootViewController: controller)
    window?.rootViewController = navController
}
```

## Output
<img src="https://user-images.githubusercontent.com/31185862/147726493-453306ca-95fe-4428-8996-c7613141c95e.png" width="300" />