// subscribe on
// change the thread upstream to the publisher

import Foundation
import PlaygroundSupport
import Combine

PlaygroundPage.current.needsIndefiniteExecution = true

var cancellable = Set<AnyCancellable>()
let intSubject = PassthroughSubject<Int, Never>()

intSubject
    .subscribe(on: DispatchQueue.global())
    .sink { value in
        print(value)
        print(Thread.current)
    }.store(in: &cancellable)

intSubject.send(1)
intSubject.send(2)
intSubject.send(3)


// Using URL Session Example

let subscription = URLSession.shared.dataTaskPublisher(for: URL(string: "https://jsonplaceholder.typicode.com")!)
    .map({ result in
        print(Thread.current.isMainThread)
    })
    .subscribe(on: DispatchQueue.main) // This won't change the upstream thread because URL session requires to be run on the background thread. If we have a publisher that doesn't specify the thread this subscribe(on:) would've changed the upstream's thread
    .receive(on: DispatchQueue.main)
    .sink(receiveCompletion: { _ in }, receiveValue: { value in
        print(Thread.current.isMainThread)
    })
