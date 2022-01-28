//
//  TodoListModel.swift
//  CombineMVVMAPITodo
//
//  Created by monish-pt4649 on 27/01/22.
//

import Foundation
import Combine

class TodoListModel {
    
    let todos = CurrentValueSubject<[Todo], Never>([Todo(title: "Default Todo", notes: "Default Notes")])
    
    var addNewTodo = PassthroughSubject<Todo, Never>()
    
    
    var subscriptions = Set<AnyCancellable>()
    
    init () {
        addNewTodo
            .sink { _ in
        } receiveValue: { [unowned self] newTodo in
            self.todos.send(self.todos.value + [newTodo])
        }.store(in: &subscriptions)
    }
}
    
