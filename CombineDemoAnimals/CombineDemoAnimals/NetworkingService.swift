//
//  NetworkingService.swift
//  CombineDemoAnimals
//
//  Created by monish-pt4649 on 17/01/22.
//

import Combine
import Foundation

enum NetworkingService {
    static func getAnimals() -> Future<[Animal], Error> {
        return Future { promise in
            let animals: [Animal] = [.dog, .cat, .frog, .panda, .lion]
            promise(.success(animals))
        }
    }
}
