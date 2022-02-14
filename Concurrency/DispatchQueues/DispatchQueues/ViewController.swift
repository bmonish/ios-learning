//
//  ViewController.swift
//  DispatchQueues
//
//  Created by monish-pt4649 on 22/02/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getData()
    }

    func calculateSomething() {
        DispatchQueue.global(qos: .background).async {
            print("I'm running on a background thread. \(Thread.isMainThread)")
        }
    }
    func getData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard data != nil else { return }
            
            DispatchQueue.main.async {
                self?.view.backgroundColor = .red
            }
        }
        
        task.resume()
    }

}

