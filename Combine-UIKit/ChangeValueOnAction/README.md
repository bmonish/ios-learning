## Change a Value when an Action is Triggered using Combine

___

## Output:

<img src="https://user-images.githubusercontent.com/31185862/150362164-b43e16bf-210c-426d-8a5b-cce143301f82.png" width="300" />
<img src="https://user-images.githubusercontent.com/31185862/150362170-7296c2e9-0f5e-493c-89b2-4ea8a29a6453.png" width="300" />

___

## Explanation:

Creating a notification name for us to trigger that notification

```swift
extension Notification.Name {
    static let newBlogPost = Notification.Name("newPost")
}
```

When the `publishButton` is pressed we are getting the text friend the `blogTextField` and setting it to the variable `title`. If there is no title present we are setting it to "Coming Soon".

We then create a `blogPost` with that title and trigger the `Notification` named `newBlogPost` with the object we just created. (`blogPost`)

```swift
@objc
func publishButtonTapped(_ sender: UIButton) {
    let title = blogTextField.text ?? "Coming Soon"
    let blogPost = BlogPost(title: title)
    NotificationCenter.default.post(name: .newBlogPost, object: blogPost)
}
````

Creating a publisher for the notification for the name `blogPost` and when the notification is triggered we take the object passed and return the `title` for the subscriber to use

```swift
let publisher = NotificationCenter.Publisher(center: .default, name: .newBlogPost, object: nil)
    .map { (notification) -> String? in
        return (notification.object as? BlogPost)?.title ?? ""
    }
```

We then create a `subscriber` and assign the `textLabel`'s `text` field and add this subscriber to our `publisher`.

```swift
let subscriber = Subscribers.Assign(object: textLabel, keyPath: \.text)
publisher.subscribe(subscriber)
```

___