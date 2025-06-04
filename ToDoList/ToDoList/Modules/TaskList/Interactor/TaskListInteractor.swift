//
//  TaskListInteractor.swift
//  ToDoList
//
//  Created by Galina Abdurashitova on 30.05.2025.
//

import Foundation

protocol TaskListInteractorProtocol {
    func fetchTasks() -> [Task]
    func addTask(title: String)
    func toggleTask(id: UUID)
}

final class TaskListInteractor: TaskListInteractorProtocol {
    private let repository: TaskRepositoryProtocol

    init(repository: TaskRepositoryProtocol = TaskRepository()) {
        self.repository = repository
    }

    func fetchTasks() -> [Task] {
        repository.getAll()
    }

    func addTask(title: String) {
        repository.add(title: title)
    }
    
    func toggleTask(id: UUID) {
        repository.toggle(id: id)
    }
}
