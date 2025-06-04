//
//  TaskRepository.swift
//  ToDoList
//
//  Created by Galina Abdurashitova on 30.05.2025.
//

import Foundation
import CoreData

protocol TaskRepositoryProtocol {
    func getAll() -> [Task]
    func add(title: String)
    func toggle(id: UUID)
}

final class TaskRepository: TaskRepositoryProtocol {
    private let container: NSPersistentContainer

    init(container: NSPersistentContainer = PersistenceController.shared.container) {
        self.container = container
    }

    func getAll() -> [Task] {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        guard let result = try? container.viewContext.fetch(request) else { return [] }

        return result.compactMap { entity in
            guard let id = entity.id, let title = entity.title else { return nil }
            return Task(id: id, title: title, isDone: entity.isDone)
        }
    }

    func add(title: String) {
        let entity = TaskEntity(context: container.viewContext)
        entity.id = UUID()
        entity.title = title
        entity.isDone = false
        try? container.viewContext.save()
    }

    func toggle(id: UUID) {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        guard let result = try? container.viewContext.fetch(request), let entity = result.first else { return }

        entity.isDone.toggle()
        try? container.viewContext.save()
    }
}

