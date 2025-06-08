//
//  ToDoListUITests.swift
//  ToDoListUITests
//
//  Created by Galina Abdurashitova on 30.05.2025.
//

import XCTest

final class ToDoListUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-UITestsReset")
        app.launch()
    }
    
    func testEmptyStateIsShownWhenNoTasks() {
        let emptyText = app.staticTexts["EmptyStateTitle"]
        XCTAssertTrue(emptyText.waitForExistence(timeout: 2))
    }

    func testAddingTaskAppearsInList() {
        app.buttons["OpenTaskInputButton"].tap()

        let input = app.textFields["NewTaskInput"]
        XCTAssertTrue(input.waitForExistence(timeout: 2))

        input.tap()
        input.typeText("Buy milk")

        app.buttons["AddButton"].tap()

        let fieldDisappeared = input.waitForExistence(timeout: 1) == false
        XCTAssertTrue(fieldDisappeared, "Input field should disappear after adding")
        
        let taskCell = app.staticTexts["TaskTitle-Buy milk"]
        print("Exists:", taskCell.exists)
        XCTAssertTrue(taskCell.exists)
    }

    func testTogglingTaskShowsCheckmark() {
        app.buttons["OpenTaskInputButton"].tap()

        let input = app.textFields["NewTaskInput"]
        XCTAssertTrue(input.waitForExistence(timeout: 2))

        input.tap()
        input.typeText("Clean room")
        app.buttons["AddButton"].tap()

        let toggle = app.buttons["Toggle-Clean room-circle"]
        XCTAssertTrue(toggle.waitForExistence(timeout: 3), "Toggle button did not appear")
        XCTAssertTrue(toggle.isHittable, "Toggle is not tappable")
        toggle.tap()
        
        let toggledCheckmark = app.buttons["Toggle-Clean room-checkmark"]
        XCTAssertTrue(toggledCheckmark.waitForExistence(timeout: 3), "Checkmark not appeared")
    }

    func testAddButtonDoesNothingWhenInputIsEmpty() {
        app.buttons["OpenTaskInputButton"].tap()
        app.buttons["AddButton"].tap()

        let list = app.tables["TaskList"]
        XCTAssertEqual(list.cells.count, 0)
    }

    func testInputSheetClosesAfterAddingTask() {
        app.buttons["OpenTaskInputButton"].tap()

        let input = app.textFields["NewTaskInput"]
        XCTAssertTrue(input.exists)
        input.tap()
        input.typeText("Do dishes")

        app.buttons["AddButton"].tap()

        XCTAssertFalse(input.waitForExistence(timeout: 1))
    }
    
    func testDeletingTaskRemovesItFromList() {
        app.buttons["OpenTaskInputButton"].tap()
        
        let input = app.textFields["NewTaskInput"]
        XCTAssertTrue(input.waitForExistence(timeout: 2))
        input.tap()
        input.typeText("Buy cheese")
        app.buttons["AddButton"].tap()
        
        let task = app.staticTexts["TaskTitle-Buy cheese"]
        XCTAssertTrue(task.waitForExistence(timeout: 2))

        task.swipeLeft()
        app.buttons["Delete"].tap()

        XCTAssertFalse(task.waitForExistence(timeout: 2), "Task should be removed after deletion")
    }

}
