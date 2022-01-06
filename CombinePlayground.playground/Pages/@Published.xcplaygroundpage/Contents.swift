import Combine
import Foundation

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

let viewModel = ViewModel()

// adding a new user
viewModel.newUserNameEntered.send("Susan")

// By default @Published Publishers acts like AnyPublisher so you can't send new values and it will throw and error
// viewModel.userNames.send("New Value")
