//
//  Reminder.swift
//  Today
//
//  Created by monish-pt4649 on 23/11/21.
//

import Foundation

struct Reminder {
    var id: String
    var title: String
    var dueDate: Date
    var notes: String? = nil
    var isComplete: Bool = false
}
