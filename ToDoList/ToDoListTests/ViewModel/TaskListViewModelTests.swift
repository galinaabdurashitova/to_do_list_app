//
//  TaskListViewModelTests.swift
//  ToDoListTests
//
//  Created by Galina Abdurashitova on 04.06.2025.
//

import XCTest
@testable import ToDoList

final class TaskListViewModelTests: XCTestCase {
    final class StubInteractor: TaskListInteractorProtocol {
        var tasks: [Task] = []
        var addCalled = false
        var toggleCalledWith: UUID?
        var deletedID: UUID?

        func fetchTasks() -> [Task] {
            return tasks
        }

        func addTask(title: String) {
            addCalled = true
            tasks.append(Task(id: UUID(), title: title, isDone: false))
        }

        func toggleTask(id: UUID) {
            toggleCalledWith = id
            if let index = tasks.firstIndex(where: { $0.id == id }) {
                let t = tasks[index]
                tasks[index] = Task(id: t.id, title: t.title, isDone: !t.isDone)
            }
        }
        
        func deleteTask(id: UUID) {
            deletedID = id
            tasks.removeAll { $0.id == id }
        }
    }

    func testInitialFetch() {
        let stub = StubInteractor()
        stub.tasks = [Task(id: UUID(), title: "Sample", isDone: false)]

        let viewModel = TaskListViewModel(interactor: stub)
        XCTAssertEqual(viewModel.tasks.count, 1)
    }

    func testAddTaskUpdatesTasks() {
        let stub = StubInteractor()
        let viewModel = TaskListViewModel(interactor: stub)
        viewModel.addTask(title: "New Task")

        XCTAssertTrue(stub.addCalled)
        XCTAssertEqual(viewModel.tasks.count, 1)
        XCTAssertEqual(viewModel.tasks.first?.title, "New Task")
    }

    func testToggleTaskCallsInteractor() {
        let id = UUID()
        let stub = StubInteractor()
        stub.tasks = [Task(id: id, title: "Do it", isDone: false)]
        let viewModel = TaskListViewModel(interactor: stub)

        viewModel.toggleDone(id: id)

        XCTAssertEqual(stub.toggleCalledWith, id)
        XCTAssertTrue(viewModel.tasks.first?.isDone ?? false)
    }
    
    func testDeleteTaskUpdatesTasks() {
        let id = UUID()
        let stub = StubInteractor()
        stub.tasks = [Task(id: id, title: "To Delete", isDone: false)]
        
        let viewModel = TaskListViewModel(interactor: stub)

        viewModel.deleteTask(id: id)

        XCTAssertEqual(stub.deletedID, id)
        XCTAssertTrue(viewModel.tasks.isEmpty)
    }
}
