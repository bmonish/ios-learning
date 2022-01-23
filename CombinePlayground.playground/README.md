# Combine Playground

## Contents:

1. [Creating Subscriptions](#creating-subscriptions)
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

Breakdown:

- Publisher
For this publisher we can give the frequency `every` which defines the interval in which the publisher emits the event and we can also define the `thread` and the `scheduler options`. And we use auto connect to connect to the publisher.

```swift
Timer.publish(every: 0.5, on: .main, in: .common)
    .autoconnect()
```

<a name="limited-subscriptions"></a>
## Limited Subscriptions