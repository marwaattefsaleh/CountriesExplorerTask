//
//  HomeViewUITests.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//

import XCTest

final class HomeViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("--UITestMode") // Optional if you want test mode
        app.launch()
    }

    func testAddCountryButtonNavigation() {
        let addButton = app.buttons["addCountryButton"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 10))
        addButton.tap()
               
        let lbl = app.staticTexts["noCountriesFoundLabel"]
        XCTAssertTrue(lbl.waitForExistence(timeout: 10))
    }

    func testTapCountryNavigatesToDetails() {
        // Add a country for test
        // You need a mechanism to inject a country in UITest mode
        // Example: first cell
        let firstCell = app.scrollViews.otherElements["countryCell_0"]
        XCTAssertTrue(firstCell.waitForExistence(timeout: 10))
        firstCell.tap()
        
        // Check that CountryDetailsView is shown
        let capitalLabel = app.staticTexts["capitalLabel"]
        XCTAssertTrue(capitalLabel.waitForExistence(timeout: 2))
    }
}
