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
