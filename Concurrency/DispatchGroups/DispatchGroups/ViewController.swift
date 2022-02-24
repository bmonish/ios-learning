//
//  ViewController.swift
//  DispatchGroups
//
//  Created by monish-pt4649 on 22/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    let waitTimes: [TimeInterval] = [
        1,
        3,
        5,
        8,
        2,
        7
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData() {
        let group = DispatchGroup()
        
        for number in waitTimes {
            
            group.enter()
            print("Entering group with number: \(number)")
            
            DispatchQueue.global().asyncAfter(deadline: .now() + number, execute: {
                group.leave()
                print("Leaving group for \(number)")
            })
            
        }
        
        group.notify(queue: .main, execute: {
            print("Done with all operations")
            self.view.backgroundColor = .blue
        })
    }
}

