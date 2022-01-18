//
//  Todos.swift
//  CombineTodo
//
//  Created by monish-pt4649 on 18/01/22.
//

import Foundation

struct Todo {
    let title: String
    let notes: String?
}

extension Todo {
    static var todos = [Todo(title: "Todo 1", notes: nil), Todo(title: "Todo 2", notes: nil)]
}
