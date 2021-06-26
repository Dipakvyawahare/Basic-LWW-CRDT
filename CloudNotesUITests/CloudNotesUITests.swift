//
//  CloudNotesUITests.swift
//  CloudNotesUITests
//
//  Created by Dipak V. Vyawahare on 26/06/21.
//

import XCTest

class CloudNotesUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        app.launch()
    }

    func testNotes() throws {
        let firstTextField = app.textFields["User 1 "]
        _ = firstTextField.waitForExistence(timeout: 2)
        firstTextField.tap()
        app.keys["q"].tap()
        app.keys["w"].tap()
        app.keys["e"].tap()
        app.keys["r"].tap()

        app.textFields["User 2"].tap()
        app.keys["t"].tap()
        app.keys["y"].tap()
        app.keys["delete"].tap()

        let label = app.staticTexts["qwert"]
        XCTAssert(label.waitForExistence(timeout: 2), "Notes UITest failed")
    }
}
