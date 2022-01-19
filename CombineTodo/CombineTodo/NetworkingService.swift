//
//  NetworkingService.swift
//  CombineTodo
//
//  Created by monish-pt4649 on 18/01/22.
//

import Foundation
import Combine

enum NetworkingService {
    
    static func getTodos() -> Future<[Todo], Error> {
        return Future { promise in
            let todos = Todo.todos
            promise(.success(todos))
        }
    }
    
    static func saveTodo(title: String, notes: String?) -> Future<Todo, Error> {
        return Future { promise in
            let todo = Todo(title: title, notes: notes)
            Todo.todos.append(todo)
            promise(.success(todo))
        }
    }
    
    static func getTodo(_ atIndex: Int) -> Future<Todo, Error> {
        return Future { promise in
            let todo = Todo.todos[atIndex]
            promise(.success(todo))
        }
    }
    
    static func updateTodo(at atIndex: Int, title: String, notes: String?) -> Future<Todo, Error> {
        return Future { promise in
            Todo.todos[atIndex].title = title
            Todo.todos[atIndex].notes = notes
            let updatedTodo = Todo.todos[atIndex]
            promise(.success(updatedTodo))
        }
    }
    static func deleteTodo(at atIndex: Int) -> Future<Todo, Error> {
        return Future { promise in
            let deletedTodo = Todo.todos.remove(at: atIndex)
            promise(.success(deletedTodo))
        }
    }
}
