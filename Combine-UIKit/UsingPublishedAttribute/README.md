## Using Published Attributes

___
<img src="https://user-images.githubusercontent.com/31185862/150397222-649ab1b0-a135-40dc-8e61-a6068b292624.png" width="300" />
<img src="https://user-images.githubusercontent.com/31185862/150397230-8fca4456-2940-4f50-aa65-1a5d49a43e13.png" width="300" />

___

## Explanation:

The `@Published` attribute will provide a publisher for us to use. 

```swift
@Published private var acceptedTerms = false
@Published private var acceptedPrivacy = false
@Published private var name = ""
```

Since we already have a publisher, we can directly use it. Here we are going to Combine the three publisher and create our own publisher which meets our requirement.

```swift
private var validToSubmit: AnyPublisher<Bool, Never> {
    return Publishers.CombineLatest3($acceptedTerms, $acceptedPrivacy, $name)
        .map { terms, privacy, name in
            return terms && privacy && !name.isEmpty
        }.eraseToAnyPublisher()
}
```