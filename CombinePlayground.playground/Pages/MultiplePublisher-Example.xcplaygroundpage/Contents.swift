import UIKit
import Combine

class ViewModel {
    
    //let userNames = CurrentValueSubject<[String], Never>(["Bill"])
    // Incase if we don't want to expose the userNamesSubject to public and protect how it gets updated we can do the following
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

let viewModel = ViewModel()

// Adding a new User "Susan"
viewModel.newUserNameEntered.send("Susan")

// This will get filtered
viewModel.newUserNameEntered.send("Ab")

// Adding another User named "Bob"
viewModel.newUserNameEntered.send("Bob")

// Protected path - This will thrown an error
//viewModel.userNames.send("Another Name")
