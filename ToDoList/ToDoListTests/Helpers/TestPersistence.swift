//
//  TestPersistence.swift
//  ToDoListTests
//
//  Created by Galina Abdurashitova on 04.06.2025.
//

import CoreData

func makeInMemoryContainer() -> NSPersistentContainer {
    let container = NSPersistentContainer(name: "Tasks")
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    container.persistentStoreDescriptions = [description]

    container.loadPersistentStores { _, error in
        if let error = error {
            fatalError("Failed to load in-memory store: \(error)")
        }
    }

    container.viewContext.automaticallyMergesChangesFromParent = true
    return container
}
