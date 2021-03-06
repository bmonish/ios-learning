# Combine Playground

## Contents:

1. [Creating Subscriptions](#creating-subscriptions) - [(Go to File)](https://github.com/bmonish/ios-learning/blob/master/CombinePlayground.playground/Pages/CreatingSubscription.xcplaygroundpage/Contents.swift)
2. [Limited Subscriptions](#limited-subscriptions) - [(Go to File)](https://github.com/bmonish/ios-learning/blob/master/CombinePlayground.playground/Pages/LimitedSubscriptions.xcplaygroundpage/Contents.swift)
3. [Assign To and On Subscriber](#assign-to-and-on-subscriber) - [(Go to File)](https://github.com/bmonish/ios-learning/blob/master/CombinePlayground.playground/Pages/assignToOn.xcplaygroundpage/Contents.swift)
4. [Assign UIKit Example](#assign-uikit-example) - [(Go to File)](https://github.com/bmonish/ios-learning/blob/master/CombinePlayground.playground/Pages/AssignUIKit.xcplaygroundpage/Contents.swift)
5. [Assign to Memory Cycle](#assign-to-memory-cycle) - [(Go to File)](https://github.com/bmonish/ios-learning/blob/master/CombinePlayground.playground/Pages/AssignExample.xcplaygroundpage/Contents.swift)
6. [Assign To](#assign-to) - [(Go to File)](https://github.com/bmonish/ios-learning/blob/master/CombinePlayground.playground/Pages/AssignTo.xcplaygroundpage/Contents.swift)
7. [Receive On](#receive-on) - [(Go to File)](https://github.com/bmonish/ios-learning/blob/master/CombinePlayground.playground/Pages/MultiThreading-ReceiveOn.xcplaygroundpage/Contents.swift)
8. [Subscribe On](#subscribe-on) - [(Go to File)](https://github.com/bmonish/ios-learning/blob/master/CombinePlayground.playground/Pages/MultiThreading-SubscribeOn.xcplaygroundpage/Contents.swift)
9. [Subscription Pattern](#subscription-pattern) - [(Go to File)](https://github.com/bmonish/ios-learning/blob/master/CombinePlayground.playground/Pages/SubscriptionPattern.xcplaygroundpage/Contents.swift)
10. [CurrentValueSubject Publisher](#currentvaluesubject-publisher) - [(Go to File)](https://github.com/bmonish/ios-learning/blob/master/CombinePlayground.playground/Pages/CurrentValueSubject.xcplaygroundpage/Contents.swift)
11. [PassthroughSubject Publisher](#passthroughsubject-publisher) - [(Go to File)](https://github.com/bmonish/ios-learning/blob/master/CombinePlayground.playground/Pages/PassthroughSubject.xcplaygroundpage/Contents.swift)
12. [@Published Wrapper](#published-wrapper) - [(Go to File)](https://github.com/bmonish/ios-learning/blob/master/CombinePlayground.playground/Pages/%40Published.xcplaygroundpage/Contents.swift)
___

## Creating Subscriptions

### Publisher
`Publisher` provides a data stream for us to subscribe to and listen. It only provides data as long as there is a `subscriber` to listen to. `Foundation` has certain publishers by default for us to directly utilize.

### Operators
We can use certain operators like `scan` and `filter` to modify or make additional changes to the data stream.

### Subscribers
They are used to subscribe and listen to the publisher. The subscription can be cancelled using `subscription.cancel()` or by setting the subscription variable to `nil`

___

#### Code:

```swift
var subscription: AnyCancellable? = Timer.publish(every: 0.5, on: .main, in: .common)
    .autoconnect()
    .throttle(for: .seconds(2), scheduler: DispatchQueue.main, latest: true)
    .scan(0, { (count, _) in
        return count + 1
    })
    .filter({ count in
        return count < 6
    })
    .sink { completion in
        print("Data Stream Completion: \(completion)")
    } receiveValue: { time in
        print("Received Value: \(time)")
    }
```

#### Breakdown:

- **Publisher**:

    For this publisher we can give the frequency `every` which defines the interval in which the publisher emits the event and we can also define the `thread` and the `scheduler options`. And we use auto connect to connect to the publisher.

```swift
Timer.publish(every: 0.5, on: .main, in: .common)
    .autoconnect()
```

- **Subscriber**:

    We have a method `sink` to receive the completion and value. It takes two closure handlers and runs whenever it receives a completion and a value.

```swift
.sink { completion in
    print("Data Stream Completion: \(completion)")
} receiveValue: { time in
    print("Received Value: \(time)")
}
```

- **Operators**:

    We use operators to modify the data stream. `scan` is used to store the previous value and modify it. It takes the initial value and calculates the next result.

```swift
.scan(0, { (count, _) in
    return count + 1
})
```

`filter` is used to allow only certain values to be passed based on a boolean.

```swift
.filter({ count in
    return count < 6
})
```

`throttle` works as a debounce and it takes in an `interval`, `scheduler` and whether to use the `first` or the `latest` value within that time frame.

```swift
.throttle(for: .seconds(2), scheduler: DispatchQueue.main, latest: true)
```

___

## Limited Subscriptions

They are subsricptions which pass through a limited number of values. For example iterating through an array. So the following code creates an Publisher named `foodbank` and we use a subscription to iterate through that sequence. The publisher reaches the end when it finishes iterating to through all the elements of array. So the `completion` in `sink` will be executed.

```swift
let foodbank: Publishers.Sequence<[String], Never> = ["apple", "bread", "orange", "milk"].publisher

let subscription = foodbank
    .sink { (completion) in
        print("Completion: \(completion)")
    } receiveValue : { foodItem in
        print("Receive Item \(foodItem)")
    }
```

We can use `zip` to combine two publishers. It excepts the length of the both publishers to be same and terminates the data stream when there is a mismatch.

```swift
var subscription = foodbank.zip(timer)
    .sink { (completion) in
        print("Completion: \(completion)")
    } receiveValue : { (foodItem, timestamp) in
        print("Receive Item \(foodItem) with \(timestamp)")
    }
```

The completion has two types: `finished` and `failure`. We can use them to further customize the behaviour of the subscriber.

```swift
var subscription = foodbank.zip(timer)
    .sink { (completion) in
        switch completion {
        case .finished:
            print("Completion: Finished")
        case .failure(let error):
            print("Completion with failure: \(error.localizedDescription)")
        }
    } receiveValue : { (foodItem, timestamp) in
        print("Receive Item \(foodItem) with \(timestamp)")
    }
```

Since this never gonna fail, we are gonna mimic a error behaviour by writing some additional code. We are mapping the tuple and calling the `throwAtEndDate` function which gives a combined string and if the timestamp exceeds a certain `endDate` it throws an error. (`MyError`). In this case the subscription ends before the stream completes and it will be handled by `.failure` case inside the switch statement in the sink.

```swift
func throwAtEndDate(_ foodItem: String, _ date: Date) throws -> String {
    if date < endDate {
        return "\(foodItem) at \(date)"
    } else {
        throw MyError()
    }
}

var subscription = foodbank.zip(timer)
    .tryMap({ (foodItem, timestamp) in
        try throwAtEndDate(foodItem, timestamp)
    })
    .sink { (completion) in
        switch completion {
        case .finished:
            print("Completion: Finished")
        case .failure(let error):
            print("Completion with failure: \(error.localizedDescription)")
        }
    } receiveValue : { (result) in
        print("Receive Item \(result)")
    }
```

___

## Assign To and On Subscriber

This type of subscriber is used to assign values to the property of a reference type value. For example classes.

```swift
class MyClass {
    var anInt: Int = 0 {
        didSet {
            print("anInt was set to: \(anInt)")
        }
    }
}

var myObject = MyClass()
let myRange = (0...2)

let subscription = myRange.publisher
    .map { $0 * 10 }
    .assign(to: \.anInt, on: myObject)
```

Here we have a class named `MyClass` which is of Reference type which as a property named `anInt`. Now we create a sample publisher and subscriber to iterate through `myRange` and assign the value to `anInt` property of `myObject` multiplied by 10 using `assign(to:,on:)`

___

## Assign UIKit Example

Creating a publisher named `textMessage`

```swift
var textMessage = CurrentValueSubject<String, Never>("Hello World")
```

Now we create a subscriber for the `textMessage` which unwraps the string using `compactMap` and maps it with our desired format and assigns it to the `text` property on `lable` and we are using a set of type `AnyCancellable` to store this subscription.

```swift
var subscriptions = Set<AnyCancellable>()

textMessage
    .compactMap({  $0 })
    .map({ "You typed: \($0)" })
    .assign(to: \.text, on: label)
    .store(in: &subscriptions)
```

And we make use of the textField's method to update the value of our CurrentValueSubject Publisher

```swift
@objc func updateText() {
    self.textMessage.value = textField.text ?? ""
}
```

___

## Assign to Memory Cycle

Whenever we use `assign(to:on:self)` it creates a strong reference cycle. So in that case it is recommended to use `sink`. In the following example if we use, assign the object `viewModel` never gets deinitialized. So we use sync to catch the self as `unowned self` to resolve the strong memory cyle issue.

```swift
struct User {
    let name: String
    let id: Int
}

class ViewModel {
    
    var user = CurrentValueSubject<User, Never>(User(name: "Bob", id: 1))
    var userID: Int = 1 {
        didSet {
            print("userId changed \(userID)")
        }
    }

    var subscriptions = Set<AnyCancellable>()
    
    init() {
        user
            .map(\.id)
//            .assign(to: \.userID, on: self)
            .sink { [unowned self] value in
                self.userID = value
            }
            .store(in: &subscriptions)
    }
    
    deinit {
        print("deinit")
    }
}

var viewModel: ViewModel? = ViewModel()
viewModel?.user.send(User(name: "Billy", id: 2))

viewModel = nil
```

___

## Assign To

The `assign(to:)` operator manages the life cycle of the subscription, canceling the subscription automatically when the Published instance deinitializes. Because of this, the assign(to:) operator `doesn???t return an AnyCancellable` that you???re responsible for like `assign(to:on:)` does.

```swift
class MyModel: ObservableObject {
    
    @Published var lastUpdated: Date = Date()
    
    init() {
         Timer.publish(every: 1.0, on: .main, in: .common)
             .autoconnect()
             .assign(to: &$lastUpdated)
        //inout &, accessing publisher of @Published $
    }
}
```

---

## Receive On

This is used to modify in which thread the subscription should run on going downstream. This is useful when we have to perform resource intensive task in the background and do the UI updates on the main thread.

```swift
// Creating a Publisher
let intSubject = PassthroughSubject<Int, Never>()

let subscription = intSubject
    .map { $0 } // Let's assume we are doing a resource intensive task. This can be done in the background and after it ccompletes we can switch to main thread
    .receive(on: DispatchQueue.main) // This changes the thread to main.
    .sink(receiveValue: { value in
        print("Receive Value: \(value)")
        print(Thread.current)
    })


// Sending values to Publisher
intSubject.send(1)

DispatchQueue.global().async {
    intSubject.send(2)
}
```
___

## Subscribe On

This is used incase if we want to modify the thread going upstream. But it only works if the Publisher doesn't specify a thread. For example the URL Session datTaskPublisher requires to be run on the background thread and we can't use `subscribe(on:)` to run it on the main thread.

```swift
let subscription = URLSession.shared.dataTaskPublisher(for: URL(string: "https://jsonplaceholder.typicode.com")!)
    .map({ result in
        print(Thread.current.isMainThread)
    })
    .subscribe(on: DispatchQueue.main) // This won't change the upstream thread because URL session requires to be run on the background thread. If we have a publisher that doesn't specify the thread this subscribe(on:) would've changed the upstream's thread
    .receive(on: DispatchQueue.main)
    .sink(receiveCompletion: { _ in }, receiveValue: { value in
        print(Thread.current.isMainThread)
    })
```

___

## Subscription Pattern

How the subscription pattern works is that the subscriber first subscribe to the publisher and it will receive a subscription. then the subscriber request the demand and the publisher provides the values based on the demand. Once it is completed, the subscriber receives the completion.

```swift
class MyClass {
    var anInt: Int = 0 {
        didSet {
            print("didSet \(anInt)")
        }
    }
}

let obj = MyClass()
let pub = (0...2).publisher
let subscriber = Subscribers.Assign(object: obj, keyPath: \.anInt)

let cancellable = pub
    .print("????")
    .receive(subscriber: subscriber)
```

So the Output for the above, would look like:
```
????: receive subscription: (0...2)
????: request unlimited
????: receive value: (0)
didSet 0
????: receive value: (1)
didSet 1
????: receive value: (2)
didSet 2
????: receive finished
```

___

# Publishers

There are few types of Publishers

1. Continuously Emitting values (eg. CurrentValueSubject, PassthroughSubject, @Publisher)
2. Limited Value Publishers (eg. Sequence, Just, Future, Deferred etc.)

Foundation framework has certain publishers. For example:

- Timer 
- URLSession dataTaskPublisher
- Notification
- Publisher on KVO instance - replacing target / action patterns

Type System of Publishers:

- type erasing:
- Any Publisher
- .eraseToAnyPublisher()

These are used for func that return publishers

---

## CurrentValueSubject Publisher

A Subject is a Publisher that you can use to continuously send values.

A `CurrentValueSubject` works like var that has a publisher attached to it.

```swift
struct User {
    var id: Int
    var name: String
}

let currentUserId = CurrentValueSubject<Int, Never>(1000)
let userNames = CurrentValueSubject<[String], Never>(["Bob", "Jack", "Luise"])

let currentUser = CurrentValueSubject<User, Never>(User(id: 1, name: "Bob"))

// To get the value of the CurrentValueSubject
print("Current User Id: \(currentUserId.value)")

// Subscribing to Subject
let subscription = currentUserId.sink {
    print("Completion \($0)")
} receiveValue: { value in
    print("Receive Value: \(value)")
}

// Passing down new values with Subject
currentUserId.send(1)
currentUserId.send(2)

// Sending Completion Finished with Subject
currentUserId.send(completion: .finished)

// Any values sent after the completion won't be processed
currentUserId.send(10)
```

___

## PassthroughSubject Publisher

This will not hold a default value. Used for actions / proccess which is equivalent to a function. And it also doesn't have a `value` property.

```swift
let newUserNameEntered = PassthroughSubject<String, Never>()
```

```swift
// Subscribing to the PassthroughSubject - Doesn't Have an inital value
let subscription = newUserNameEntered.sink {
    print("Completion: \($0)")
} receiveValue: { (value) in
    print("Receive Value: \(value)")
}
```

And we can pass down new values to the publisher by using the `send` method.

```swift
// Passing down new values to the Subject
newUserNameEntered.send("Bob")

// Sending Completion
newUserNameEntered.send(completion: .finished)
```

### Example of Using CurrentValueSubject and PassthroughSubject together - [Example File](https://github.com/bmonish/ios-learning/blob/master/CombinePlayground.playground/Pages/MultiplePublisher-Example.xcplaygroundpage/Contents.swift)

In this example we have userNamesSubject which is of type `CurrentValueSubject` publisher and it holds an array of strings which are userNames. Since we want this to be protected we can use `AnyPublisher`. It is a publisher that performs type erasure by wrapping another publisher.

And we create a subscription for the `newUserNameEntered` PassthrougSubject Publisher and it gets a string as input for the data stream. We use the subscription to update the values held in userNamesSubject.

And we can use the `userNames` of any `AnyPublisher` to just read the data stream.

```swift
class ViewModel {
    
    private let userNamesSubject = CurrentValueSubject<[String], Never>(["Bill"])
    var userNames: AnyPublisher<[String], Never>
    
    let newUserNameEntered = PassthroughSubject<String, Never>()
    
    var subscriptions = Set<AnyCancellable>()
    
    init () {
        userNames = userNamesSubject.eraseToAnyPublisher()
        
        // Creating a publisher stream that will updated userNames whenever a newUserNameEntered gets a new value
        newUserNameEntered
            .filter({ $0.count > 3 })
            .sink { _ in
                
            } receiveValue: { [unowned self] username in
                //            userNames.value = userNames.value + [username]
                self.userNamesSubject.send(userNamesSubject.value + [username])
            }.store(in: &subscriptions)
        
        userNames
            .sink { users in
                print("UserNames changed to \(users)")
            }.store(in: &subscriptions)
    }
}
```
Executing the above code:

```swift
let viewModel = ViewModel()

// Adding a new User "Susan"
viewModel.newUserNameEntered.send("Susan")

// This will get filtered
viewModel.newUserNameEntered.send("Ab")

// Adding another User named "Bob"
viewModel.newUserNameEntered.send("Bob")

// Protected path - This will thrown an error
//viewModel.userNames.send("Another Name")
```

___

## @Published Wrapper

It is a `property wrapper`. It adds a publisher to a property. It is used for `class` properties and not `structures.` To access a publisher of property wrapped with @Published we prefix the variable name with `$`. One main thing to note is that when using this wrapper, the property changes, publishing occurs in the property's `willSet` block, which means the subscribers receive wthe new value before it's actually set on the property

```swift
class ViewModel {
    
    // Using @Published
    @Published var userNames: [String] = ["Bill"]
    
    let newUserNameEntered = PassthroughSubject<String, Never>()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        $userNames.sink { [unowned self] value in
            print("Receive Value \(value) with \(self.userNames)")
        }.store(in: &subscriptions)
        
        newUserNameEntered.sink { [unowned self] (value) in
            self.userNames.append(value)
        }.store(in: &subscriptions)
        
    }
}
```

Executing the above code:

```swift
let viewModel = ViewModel()

// adding a new user
viewModel.newUserNameEntered.send("Susan")

// By default @Published Publishers acts like AnyPublisher so you can't send new values and it will throw and error
// viewModel.userNames.send("New Value")
```

So the output would like:

```
Receive Value ["Bill"] with ["Bill"]
Receive Value ["Bill", "Susan"] with ["Bill"]
```

You can see that when we sent Susan the userNames was still `["Bill"]`

___