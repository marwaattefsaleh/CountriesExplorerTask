//
//  CountryDetailsViewUITests.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//
import XCTest

final class CountryDetailsViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--UITestMode--details") // optional: inject mock data
        app.launch()
        
        // Navigate to a detail view first
        let firstCell = app.scrollViews.otherElements["countryCell_0"]

        XCTAssertTrue(firstCell.waitForExistence(timeout: 20))
        firstCell.tap()
        
        let capitalLabel = app.staticTexts["capitalLabel"]
        XCTAssertTrue(capitalLabel.waitForExistence(timeout: 10))

         XCTAssertTrue(capitalLabel.exists)
         XCTAssertEqual(capitalLabel.label, "Cairo")
    }

    func testCountryDetailsViewDisplaysCorrectInfo() {
        // Navigate to CountryDetailsView in your app (if needed)
        // For example, tap a cell in a list to open details

        // Example assumes the view is already presented
        let nameLabel = app.staticTexts["countryNameLabel"]
        let capitalLabel = app.staticTexts["capitalLabel"]
        let currencyLabel = app.staticTexts["currencyLabel"]
        let regionLabel = app.staticTexts["regionLabel"]
        let languagesLabel = app.staticTexts["languagesLabel"]
        let coordinatesLabel = app.staticTexts["coordinatesLabel"]
        let dismissButton = app.buttons["dismissButton"]

        XCTAssertTrue(nameLabel.exists)
        XCTAssertTrue(capitalLabel.exists)
        XCTAssertTrue(currencyLabel.exists)
        XCTAssertTrue(regionLabel.exists)
        XCTAssertTrue(languagesLabel.exists)
        XCTAssertTrue(coordinatesLabel.exists)
        XCTAssertTrue(dismissButton.exists)

        XCTAssertEqual(nameLabel.label, "Egypt")
        XCTAssertEqual(capitalLabel.label, "Cairo")
        XCTAssertEqual(currencyLabel.label, "EGP")
        XCTAssertEqual(regionLabel.label, "Africa")
        XCTAssertEqual(languagesLabel.label, "Arabic")
        XCTAssertEqual(coordinatesLabel.label, "30.033° N, 31.233° E")
    }

    func testDismissButtonClosesView() {
        let dismissButton = app.buttons["dismissButton"]
        XCTAssertTrue(dismissButton.exists)
        dismissButton.tap()

        // Assert that the view is dismissed (depends on your navigation)
        XCTAssertFalse(dismissButton.exists)
    }
}
