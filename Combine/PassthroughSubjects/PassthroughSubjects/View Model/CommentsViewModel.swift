import Foundation
import Combine

final class CommentsViewModel {
    
    private let commentEntered = PassthroughSubject<String, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    private let wordsToBeFiltered = ["hate", "danger", "accident"]
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
            .filter({ !$0.isEmpty })
            .sink { [weak self] val in
                
                guard let self = self else { return }
                
                if self.wordsToBeFiltered.contains(val) {
                    
                } else {
                    print("New Comment: \(val)")
                }
                
            }
            .store(in: &subscriptions)
    }
}
