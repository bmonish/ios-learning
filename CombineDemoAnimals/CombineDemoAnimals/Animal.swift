//
//  Animal.swift
//  CombineDemoAnimals
//
//  Created by monish-pt4649 on 17/01/22.
//

import Foundation

struct Animal {
    let name: String
    let emoji: String
    let noise: String
}

extension Animal {
    
    static let dog = Animal(name: "Dog", emoji: "🐶", noise: "ruff")
    static let cat = Animal(name: "Cat", emoji: "🐱", noise: "meow")
    static let frog = Animal(name: "Frog", emoji: "🐸", noise: "ribbit")
    static let panda = Animal(name: "Panda", emoji: "🐼", noise: "puh-panda")
    static let lion = Animal(name: "Lion", emoji: "🦁", noise: "rawr")
    
}
