# Combine Playground

## Contents:

1. [Creating Subscriptions](#creating-subscriptions) - [(Go to File)](https://github.com/bmonish/ios-learning/blob/master/CombinePlayground.playground/Pages/CreatingSubscription.xcplaygroundpage/Contents.swift)
2. [Limited Subscriptions](#limited-subscriptions)


<a name="creating-subscriptions"></a>
## Creating Subscriptions

### Publisher
`Publisher` provides a data stream for us to subscribe to and listen. It only provides data as long as there is a `subscriber` to listen to. `Foundation` has certain publishers by default for us to directly utilize.

### Operators
We can use certain operators like `scan` and `filter` to modify or make additional changes to the data stream.

### Subscribers
They are used to subscribe and listen to the publisher. The subscription can be cancelled using `subscription.cancel()` or by setting the subscription variable to `nil`

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

<a name="limited-subscriptions"></a>
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

