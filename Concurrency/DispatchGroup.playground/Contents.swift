import UIKit

func getData() {
    let urls = [
        "https://api.google.com/1",
        "https://api.google.com/2",
        "https://api.google.com/3",
    ]
    
    let group = DispatchGroup()
    
    for url in urls {
        
        guard let url = URL(string: url) else { continue }
        
        group.enter()
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            defer {
                group.leave()
            }
            
            guard let data = data else { return }
            print(data)
        })
        
        task.resume()
    }
    
    group.notify(queue: .main, execute: {
        print("Group Done")
    })
}

getData()
