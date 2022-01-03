// using multithreading - where and how to change threads
// it changes the thread goind downstream

import Foundation
import PlaygroundSupport
import Combine

PlaygroundPage.current.needsIndefiniteExecution = true

let intSubject = PassthroughSubject<Int, Never>()

let subscription = intSubject
    .map { $0 } // Let's assume we are doing a resource intensive task. This can be done in the background and after it ccompletes we can switch to main thread
    .receive(on: DispatchQueue.main)
    .sink(receiveValue: { value in
        print("Receive Value: \(value)")
        print(Thread.current)
    })

intSubject.send(1)

DispatchQueue.global().async {
    intSubject.send(2)
}
