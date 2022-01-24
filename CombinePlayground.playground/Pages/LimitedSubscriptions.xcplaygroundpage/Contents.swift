import UIKit
import Combine

// These are publishers that will pass a limited number of values

let foodbank: Publishers.Sequence<[String], Never> = ["apple", "bread", "orange", "milk"].publisher

// Infinite Publisher
var timer = Timer.publish(every: 1, on: .main, in: .common)
    .autoconnect()

//let subscription = foodbank
//    .sink { (completion) in
//        print("Completion: \(completion)")
//    } receiveValue : { foodItem in
//        print("Receive Item \(foodItem)")
//    }


// Subscription Completion types

//var subscription = foodbank.zip(timer)
//    .sink { (completion) in
//        switch completion {
//        case .finished:
//            print("Completion: Finished")
//        case .failure(let error):
//            print("Completion with failure: \(error.localizedDescription)")
//        }
//    } receiveValue : { (foodItem, timestamp) in
//        print("Receive Item \(foodItem) with \(timestamp)")
//    }


// Creating and handling an Error

let calendar = Calendar.current
let endDate = calendar.date(byAdding: .second, value: 3, to: Date())!

struct MyError: Error {}

func throwAtEndDate(_ foodItem: String, _ date: Date) throws -> String {
    if date < endDate {
        return "\(foodItem) at \(date)"
    } else {
        throw MyError()
    }
}

var subscription = foodbank.zip(timer)
    .tryMap({ (foodItem, timestamp) in
        try throwAtEndDate(foodItem, timestamp)
    })
    .sink { (completion) in
        switch completion {
        case .finished:
            print("Completion: Finished")
        case .failure(let error):
            print("Completion with failure: \(error.localizedDescription)")
        }
    } receiveValue : { (result) in
        print("Receive Item \(result)")
    }
