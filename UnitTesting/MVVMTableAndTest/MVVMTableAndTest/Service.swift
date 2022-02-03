//
//  Service.swift
//  MVVMTableAndTest
//
//  Created by monish-pt4649 on 03/02/22.
//

import Foundation

class Service {
    static let shared = Service()
    
    let testData: [Course] = [
        Course(id: 0, name: "Swift", number_of_lessons: 50),
        Course(id: 1, name: "React", number_of_lessons: 30),
        Course(id: 2, name: "JavaScript", number_of_lessons: 20),
        Course(id: 3, name: "Git", number_of_lessons: 5),
        Course(id: 4, name: "MongoDB", number_of_lessons: 35),
        Course(id: 5, name: "AWS", number_of_lessons: 20),
        Course(id: 6, name: "Java", number_of_lessons: 60),
    ]
    
}
