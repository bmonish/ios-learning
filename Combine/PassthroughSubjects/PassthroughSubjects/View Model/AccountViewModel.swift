import Foundation
import Combine

final class AccountViewModel {
    
    enum AccountStatus {
        case active
        case banned
    }
    
    private let warningLimit = 3
    
    let userAccountStatus = CurrentValueSubject<AccountStatus, Never>(.active)
    let warnings = CurrentValueSubject<Int, Never>(0)
    
    private var subscriptions = Set<AnyCancellable>()
    
}
