// Subject - Publisher that you can continuously send new values down

// CurrentValueSubject - used like a var with a publisher stream attached.

import Combine
import Foundation

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
