//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Galina Abdurashitova on 30.05.2025.
//

import SwiftUI
import CoreData

@main
struct ToDoListApp: App {
    let container = PersistenceController.shared.container

    init() {
        if CommandLine.arguments.contains("-UITestsReset") {
            let context = PersistenceController.shared.container.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try context.execute(deleteRequest)
                try context.save()
                print("UITests DB reset")
            } catch {
                print("Failed to reset Core Data: \(error)")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            let repository = TaskRepository(container: container)
            let interactor = TaskListInteractor(repository: repository)
            TaskListView(viewModel: TaskListViewModel(interactor: interactor))
        }
    }
}
