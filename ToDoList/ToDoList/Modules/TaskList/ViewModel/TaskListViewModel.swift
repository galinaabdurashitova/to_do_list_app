//
//  TaskListViewModel.swift
//  ToDoList
//
//  Created by Galina Abdurashitova on 30.05.2025.
//

import Foundation

final class TaskListViewModel: ObservableObject {
    @Published var tasks: [TaskEntity] = []

    private let interactor: TaskListInteractorProtocol

    init(interactor: TaskListInteractorProtocol = TaskListInteractor()) {
        self.interactor = interactor
        fetchTasks()
    }

    func fetchTasks() {
        tasks = interactor.fetchTasks()
    }

    func addTask(title: String) {
        interactor.addTask(title: title)
        fetchTasks()
    }

    func toggleDone(task: TaskEntity) {
        interactor.toggleTask(task)
        fetchTasks()
    }
}
