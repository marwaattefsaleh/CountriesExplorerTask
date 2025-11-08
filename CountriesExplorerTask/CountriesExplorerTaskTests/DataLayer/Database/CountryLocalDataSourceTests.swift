//
//  CountryLocalDataSourceTests.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//

import XCTest
import SwiftData
@testable import CountriesExplorerTask

final class CountryLocalDataSourceTests: XCTestCase {

    var container: ModelContainer!
    var actor: CountryModelActor!
    var localDataSource: CountryLocalDataSource!

    override func setUp() async throws {
        try await super.setUp()

        // In-memory SwiftData container
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: CountryDBModel.self, configurations: config)

        actor = CountryModelActor(modelContainer: container)
        localDataSource = CountryLocalDataSource(actor: actor)
    }

    override func tearDown() async throws {
        localDataSource = nil
        actor = nil
        container = nil
        try await super.tearDown()
    }

    func testSaveCountry_InsertsCountry() async throws {
        let country = CountryDBModel(name: "Egypt", cca2: "EG")
        try await localDataSource.saveCountry(country)

        let all = try await localDataSource.getAllCountries()
        XCTAssertEqual(all.count, 1)
        XCTAssertEqual(all.first?.name, "Egypt")
    }

    func testSaveCountry_UpdatesExistingCountry() async throws {
        let country = CountryDBModel(name: "Egypt", cca2: "EG")
        try await localDataSource.saveCountry(country)

        let updated = CountryDBModel(name: "Egypt Updated", cca2: "EG")
        try await localDataSource.saveCountry(updated)

        let all = try await localDataSource.getAllCountries()
        XCTAssertEqual(all.count, 1)
        XCTAssertEqual(all.first?.name, "Egypt Updated")
    }

    func testDeleteCountry_RemovesCountry() async throws {
        let country = CountryDBModel(name: "Egypt", cca2: "EG")
        try await localDataSource.saveCountry(country)
        try await localDataSource.deleteCountry(by: "EG")

        let all = try await localDataSource.getAllCountries()
        XCTAssertTrue(all.isEmpty)
    }

    func testGetCountry_ReturnsCountry() async throws {
        let country = CountryDBModel(name: "Egypt", cca2: "EG")
        try await localDataSource.saveCountry(country)

        let fetched = try await localDataSource.getCountry(by: "EG")
        XCTAssertEqual(fetched.name, "Egypt")
    }

    func testGetCountry_ThrowsNotFound() async throws {
        await XCTAssertThrowsErrorAsync(try await localDataSource.getCountry(by: "US")) { error in
            XCTAssertTrue(error is DatabaseError)
        }
    }
}
