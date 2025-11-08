//
//  SearchCountryViewUITests.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//

import XCTest

final class SearchCountryViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--UITestMode") // Optional: for testing mode
        app.launch()
    }

    func testSearchCountryViewUIElements() throws {
        // Navigate to SearchCountryView first, for example tapping "Add Country"
        let addButton = app.buttons["addCountryButton"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 5))
        addButton.tap()
        
        // Wait for SearchCountryView root
        let searchView = app.otherElements["searchCountryViewRoot"]
        XCTAssertTrue(searchView.waitForExistence(timeout: 5))

        // Check search text field exists
        let searchTextField = app.textFields["searchTextField"]
        XCTAssertTrue(searchTextField.exists)
        XCTAssertTrue(searchTextField.isHittable)

        // Check empty state is visible initially
        let noCountriesLabel = app.staticTexts["noCountriesFoundLabel"]
        XCTAssertTrue(noCountriesLabel.waitForExistence(timeout: 2))
        XCTAssertEqual(noCountriesLabel.label, "No results found")
    }

    func testSearchTextFieldAndClearButton() throws {
        let addButton = app.buttons["addCountryButton"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 5))
        addButton.tap()

        let lbl = app.staticTexts["noCountriesFoundLabel"]
        XCTAssertTrue(lbl.waitForExistence(timeout: 5))
        
        let searchTextField = app.textFields["searchTextField"]
        XCTAssertTrue(searchTextField.waitForExistence(timeout: 5))

        // Enter search text
        searchTextField.tap()
        searchTextField.typeText("Egypt")

        // Clear button should appear
        let clearButton = app.buttons["clearSearchButton"]
        XCTAssertTrue(clearButton.waitForExistence(timeout: 2))
        clearButton.tap()

        // Search text field should be empty
        XCTAssertEqual(searchTextField.value as? String, "Search for country...")
    }
}
