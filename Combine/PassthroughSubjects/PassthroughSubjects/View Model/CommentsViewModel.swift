import Foundation
import Combine

final class CommentsViewModel {
    
    private let commentEntered = PassthroughSubject<String, Never>()
    
    func send(comment: String) {
        commentEntered.send(comment)
    }
}
