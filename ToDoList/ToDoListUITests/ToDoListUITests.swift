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
        app.launch()
    }

    func testAddingTaskAppearsInList() {
        let input = app.textFields["NewTaskInput"]
        XCTAssertTrue(input.exists)

        input.tap()
        input.typeText("Buy milk")

        app.buttons["AddButton"].tap()

        let taskCell = app.staticTexts["Buy milk"]
        XCTAssertTrue(taskCell.exists)
    }

    func testTogglingTaskShowsCheckmark() {
        let input = app.textFields["NewTaskInput"]
        XCTAssertTrue(input.exists)

        input.tap()
        input.typeText("Clean room")
        app.buttons["AddButton"].tap()

        let cell = app.cells.containing(.staticText, identifier: "Clean room").firstMatch
        XCTAssertTrue(cell.waitForExistence(timeout: 2))

        let toggleButton = cell.images["Toggle-Clean room-circle"]
        XCTAssertTrue(toggleButton.exists)

        toggleButton.tap()

        let toggledButton = cell.images["Toggle-Clean room-checkmark"]
        XCTAssertTrue(toggledButton.waitForExistence(timeout: 2))
    }


    func testAddButtonDoesNothingWhenInputIsEmpty() {
        app.buttons["AddButton"].tap()
        let list = app.tables.firstMatch
        XCTAssertEqual(list.cells.count, 0)
    }
}
