import Foundation
import UIKit

//let mainQueue = OperationQueue.main
//
//let customQueue = OperationQueue()
//customQueue.maxConcurrentOperationCount = 30
//
//let fetchIdOperation =  Operation()
////fetchIdOperation.cancel()
//
//let fetchUserPhotoWithIdOperation = Operation()
//fetchUserPhotoWithIdOperation.addDependency(fetchIdOperation)
//
////mainQueue.addOperation(operation)
//customQueue.addOperation(fetchUserPhotoWithIdOperation)


let blockOperation = BlockOperation {
    print("Executing Block")
}

let queue = OperationQueue()
queue.addOperation(blockOperation)
