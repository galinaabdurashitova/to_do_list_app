//
//  TaskRepositoryTests.swift
//  ToDoListTests
//
//  Created by Galina Abdurashitova on 04.06.2025.
//

import XCTest
import CoreData
@testable import ToDoList

final class TaskRepositoryTests: XCTestCase {
    func testAddAndFetchTasks() {
        let container = makeInMemoryContainer()
        let repository = TaskRepository(container: container)

        repository.add(title: "Test Task")

        let tasks = repository.getAll()
        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks.first?.title, "Test Task")
        XCTAssertFalse(tasks.first?.isDone ?? true)
    }

    func testToggleChangesIsDone() {
        let container = makeInMemoryContainer()
        let repository = TaskRepository(container: container)

        repository.add(title: "Toggle Task")
        var tasks = repository.getAll()
        let id = tasks.first!.id

        repository.toggle(id: id)
        tasks = repository.getAll()
        XCTAssertTrue(tasks.first?.isDone ?? false)
    }

    func testToggleWithInvalidIDDoesNothing() {
        let container = makeInMemoryContainer()
        let repository = TaskRepository(container: container)

        repository.add(title: "Some Task")
        let invalidID = UUID()
        repository.toggle(id: invalidID)

        let tasks = repository.getAll()
        XCTAssertFalse(tasks.first?.isDone ?? true)
    }
    
    func testDeleteRemovesTask() {
        let container = makeInMemoryContainer()
        let repository = TaskRepository(container: container)

        repository.add(title: "Delete Me")
        var tasks = repository.getAll()
        XCTAssertEqual(tasks.count, 1)

        let id = tasks.first!.id
        repository.delete(id: id)

        tasks = repository.getAll()
        XCTAssertEqual(tasks.count, 0)
    }

}

