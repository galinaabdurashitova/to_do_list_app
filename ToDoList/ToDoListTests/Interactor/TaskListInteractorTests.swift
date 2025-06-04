//
//  TaskListInteractorTests.swift
//  ToDoListTests
//
//  Created by Galina Abdurashitova on 04.06.2025.
//

import XCTest
@testable import ToDoList

final class TaskListInteractorTests: XCTestCase {
    final class StubRepository: TaskRepositoryProtocol {
        var tasks: [Task] = []
        var addCalledWith: String?
        var toggleCalledWith: UUID?

        func getAll() -> [Task] {
            return tasks
        }

        func add(title: String) {
            addCalledWith = title
            tasks.append(Task(id: UUID(), title: title, isDone: false))
        }

        func toggle(id: UUID) {
            toggleCalledWith = id
            if let i = tasks.firstIndex(where: { $0.id == id }) {
                let t = tasks[i]
                tasks[i] = Task(id: t.id, title: t.title, isDone: !t.isDone)
            }
        }
    }

    func testFetchTasksDelegatesToRepository() {
        let stub = StubRepository()
        stub.tasks = [Task(id: UUID(), title: "Repo Task", isDone: false)]

        let interactor = TaskListInteractor(repository: stub)
        let tasks = interactor.fetchTasks()

        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks.first?.title, "Repo Task")
    }

    func testAddTaskDelegatesToRepository() {
        let stub = StubRepository()
        let interactor = TaskListInteractor(repository: stub)
        interactor.addTask(title: "New")

        XCTAssertEqual(stub.addCalledWith, "New")
        XCTAssertEqual(stub.tasks.first?.title, "New")
    }

    func testToggleDelegatesToRepository() {
        let id = UUID()
        let stub = StubRepository()
        stub.tasks = [Task(id: id, title: "Toggle Me", isDone: false)]

        let interactor = TaskListInteractor(repository: stub)
        interactor.toggleTask(id: id)

        XCTAssertEqual(stub.toggleCalledWith, id)
        XCTAssertTrue(stub.tasks.first?.isDone ?? false)
    }
}
