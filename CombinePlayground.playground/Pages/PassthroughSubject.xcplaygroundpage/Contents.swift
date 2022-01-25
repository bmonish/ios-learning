import UIKit
import Combine

// PassthroughSubject
// use for starting action/process - equivalent to func

// It Doesn't hold a value
let newUserNameEntered = PassthroughSubject<String, Never>()

// Getting the value will thrown an error
//print("Value held in newUserNameEntered: \(newUserNameEntered.value)")

// Subscribing to the PassthroughSubject - Doesn't Have an inital value
let subscription = newUserNameEntered.sink {
    print("Completion: \($0)")
} receiveValue: { (value) in
    print("Receive Value: \(value)")
}

// Passing down new values to the Subject
newUserNameEntered.send("Bob")

// Sending Completion
newUserNameEntered.send(completion: .finished)
