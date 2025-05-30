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

    var body: some Scene {
        WindowGroup {
            let repository = TaskRepository(container: container)
            let interactor = TaskListInteractor(repository: repository)
            TaskListView(viewModel: TaskListViewModel(interactor: interactor))
        }
    }
}
