//
//  TaskListInteractor.swift
//  ToDoList
//
//  Created by Galina Abdurashitova on 30.05.2025.
//

import Foundation

protocol TaskListInteractorProtocol {
    func fetchTasks() -> [TaskEntity]
    func addTask(title: String)
    func toggleTask(_ task: TaskEntity)
}

final class TaskListInteractor: TaskListInteractorProtocol {
    private let repository: TaskRepositoryProtocol

    init(repository: TaskRepositoryProtocol = TaskRepository()) {
        self.repository = repository
    }

    func fetchTasks() -> [TaskEntity] {
        repository.getAll()
    }

    func addTask(title: String) {
        repository.add(title: title)
    }

    func toggleTask(_ task: TaskEntity) {
        repository.toggle(task)
    }
}
