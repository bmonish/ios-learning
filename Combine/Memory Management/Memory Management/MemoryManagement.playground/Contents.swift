import UIKit
import Combine

class AccountViewModel {
    
    enum AccountState {
        case active
        case inactive
    }
    
    struct Account {
        var username: String
        var status: AccountState
    }
    
    let user = CurrentValueSubject<Account, Never>(Account(username: "bmonish",
                                                           status: .active))
    private var accountState: AccountState = .active {
        
        didSet {
            print("The user's account status changed: \(accountState)")
        }
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        // The following creates a strong reference
        /*
         user
         .map(\.status)
         .assign(to: \.accountState, on: self)
         .store(in: &subscriptions)
         */
        
        // Method to fix it
        user
            .map(\.status)
            .sink { [weak self] val in
                self?.accountState = val
            }
            .store(in: &subscriptions)
    }
    
    deinit {
        print("deinit released AccountViewModel")
    }
}

var viewModel: AccountViewModel? = AccountViewModel()

viewModel?.user.value.status = .inactive

viewModel = nil
