import Foundation
import Combine

final class CommentsViewModel {
    
    private let commentEntered = PassthroughSubject<String, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    init () {
        setupSubscriptions()
    }
    
    func send(comment: String) {
        commentEntered.send(comment)
    }
}

private extension CommentsViewModel {
    
    func setupSubscriptions() {
        
        commentEntered
            .filter({ $0.isEmpty })
            .sink { val in
                print("New Comment: \(val)")
            }
            .store(in: &subscriptions)
    }
}
