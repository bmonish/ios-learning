//
//  CourseViewModel.swift
//  MVVMTableAndTest
//
//  Created by monish-pt4649 on 03/02/22.
//

import Foundation
import UIKit

struct CourseViewModel {
    
    let name: String
    
    let detailTextString: String
    let accessoryType: UITableViewCell.AccessoryType
    
    // Dependency Injection (DI)
    init(course: Course) {
        self.name = course.name
        
        if course.number_of_lessons > 35 {
            detailTextString = "Lessons 30+ Check it Out!"
            accessoryType = .detailDisclosureButton
        } else {
            detailTextString = "Lessons: \(course.number_of_lessons)"
            accessoryType = .none
        }
    }
    
}
