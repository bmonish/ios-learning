import UIKit
import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

struct Todo: Decodable {
    var title: String
    var notes: String
}

struct Response: Decodable {
    var results: [Todo]
}

let json = [
    "title": "Todo from URL",
    "notes": "Notes from URL Todo"
]

let jsonData = try! JSONSerialization.data(withJSONObject: json)

let url = URL(string: "http://localhost:8080/api/todos")!

var request = URLRequest(url: url)
request.httpMethod = "POST"

// insert json data to the request
request.httpBody = jsonData

//IMPORTANT
request.addValue("application/json", forHTTPHeaderField: "Content-Type")
request.addValue("application/json", forHTTPHeaderField: "Accept")

let task = URLSession.shared.dataTask(with: request) { data, response, error in
    guard let data = data, error == nil else {
        print(error?.localizedDescription ?? "No data")
        return
    }
    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
    if let responseJSON = responseJSON as? [String: Any] {
        print(responseJSON)
    }
}

task.resume()




//class MyModel {
//    var tasksArray: [Todo]
//
//    init () {
//        let url: URL = URL(string: "http://localhost:8080/api/todos/all")!
//
//        let _ = URLSession.shared.dataTaskPublisher(for: url)
//            .map({ (data, response) -> [Todo] in
//                print("Data:", data)
//                var results: Response?
//                do {
//                    results = try JSONDecoder().decode(Response.self, from: data)
//                    print(results?.results)
//                } catch let err {
//                    print(err)
//                }
//                let dataArray = results?.results
//                return dataArray ?? []
//            })
//            .receive(on: DispatchQueue.main)
//            .sink { _ in
//                print("Thread", Thread.current.isMainThread)
//                print("Completion")
//            } receiveValue: { [unowned self] values in
//                print("Receving", values)
//                self.tasksArray = values
//            }.store(in: &subscriptions)
//    }
//}
