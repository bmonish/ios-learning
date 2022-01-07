import UIKit
import Combine

// These are publishers that will pass a limited number of values

let foodbank: Publishers.Sequence<[String], Never> = ["apple", "bread", "orange", "milk"].publisher

let subscription = foodbank
    .sink { (completion) in
        print("Completion: \(completion)")
    } receiveValue : { foodItem in
        print("Receive Item \(foodItem)")
    }
