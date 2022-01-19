//
//  Todos.swift
//  CombineTodo
//
//  Created by monish-pt4649 on 18/01/22.
//

import Foundation

struct Todo {
    var title: String
    var notes: String?
}

extension Todo {
    static var todos = [Todo(title: "Todo 1", notes: nil), Todo(title: "Todo 2", notes: "This is the description written for Todo 2")]
}
