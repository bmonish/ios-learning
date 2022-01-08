## Combining and Validating Data with Publishers

## Output:

https://user-images.githubusercontent.com/31185862/150511994-f76ddd5f-677a-46ac-8896-734f2e196e84.mp4

## Explanation:

First we are creating three `@Published` property variables. Namely, `username`, `password` and `passwordAgain`.

```swift
@Published var password = ""
@Published var passwordAgain = ""
@Published var username: String = ""
```

Then we are creating a Publisher `validatedUsername` to check whether the `username` is valid. This mimics a api call by returning a Future which calls the `usernameAvailable` function which is nothing but a dummy function that does nothing.

```swift
var validatedUsername: AnyPublisher<String?, Never> {
    return $username
        .debounce(for: 0.5, scheduler: RunLoop.main)
        .removeDuplicates()
        .flatMap { username in
            return Future { promise in
                self.usernameAvailable(username) { available in
                    promise(.success(available ? username : nil))
                }
            }
        }
        .eraseToAnyPublisher()
}
```

The Dummy Function:

```swift
func usernameAvailable(_ username: String, completion: (Bool) -> Void) {
    completion(true)
}
```

We are creating another publisher `validatedPassword` to see if both the passwords are equal and also if it's not equal to something simple like `"password1"`. This works with the two @Published properties we declared at the beginning and combines them.

```swift
var validatedPassword: AnyPublisher<String?, Never> {
    return Publishers.CombineLatest($password, $passwordAgain)
        .map { password, passwordRepeat in
            guard password == passwordRepeat, password.count > 0 else { return nil }
            return password
        }
        .map {
            ($0 ?? "") == "password1" ? nil : $0
        }
        .eraseToAnyPublisher()
}
```

Finally we have a publisher `validatedCredentials` to combine these two publishers and decide whether signup button should be enabled or not.

```swift
 var validatedCredentials: AnyPublisher<(String, String)?, Never> {
    return Publishers.CombineLatest(validatedUsername, validatedPassword)
        .receive(on: RunLoop.main)
        .map { username, password in
            guard let uname = username, let pwd = password else { return nil }
            return (uname, pwd)
        }
        .eraseToAnyPublisher()
}
```

---

Defining our subscriber:

```swift
var signUpButtonSubscriber: AnyCancellable?
```

Connecting our `signUpButtonSubscriber` to our `validatedCredentials` publisher. This checks whether the validation is nill or not and enables the button if the credentials are properly validated.

```swift
signUpButtonSubscriber = validatedCredentials
        .map { $0 != nil }
        .receive(on: RunLoop.main)
        .assign(to: \.isEnabled, on: signUpButton)
```

___