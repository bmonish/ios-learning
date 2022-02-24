import UIKit

// Serial vs. Concurrent

let queue = DispatchQueue(label: "bmonish.queue", attributes: .concurrent)

// Sync Blocks
queue.sync {
    print("Begin: Task 1")
    print("End: Task 1")
}

queue.sync {
    print("Begin: Task 2")
    print("End: Task 2")
}

// Async Blocks
queue.async {
    print("Begin: Task 3")
    print("End: Task 3")
}

queue.async {
    print("Begin: Task 4")
    print("End: Task 4")
}
