//
//  TaskRepository.swift
//  ToDoList
//
//  Created by Galina Abdurashitova on 30.05.2025.
//

import Foundation
import CoreData

protocol TaskRepositoryProtocol {
    func getAll() -> [TaskEntity]
    func add(title: String)
    func toggle(_ task: TaskEntity)
}

final class TaskRepository: TaskRepositoryProtocol {
    private let container: NSPersistentContainer

    init(container: NSPersistentContainer = PersistenceController.shared.container) {
        self.container = container
    }

    func getAll() -> [TaskEntity] {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        return (try? container.viewContext.fetch(request)) ?? []
    }

    func add(title: String) {
        let new = TaskEntity(context: container.viewContext)
        new.id = UUID()
        new.title = title
        new.isDone = false
        try? container.viewContext.save()
    }

    func toggle(_ task: TaskEntity) {
        task.isDone.toggle()
        try? container.viewContext.save()
    }
}
