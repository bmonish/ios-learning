import Combine
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// Foundation: has a couple of publishers to it which we can directly use

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

DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
//    subscription.cancel()
    subscription = nil
}
