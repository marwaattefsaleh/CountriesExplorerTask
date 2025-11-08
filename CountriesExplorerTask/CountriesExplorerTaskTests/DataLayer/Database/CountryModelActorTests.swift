//
//  CountryModelActorTests.swift
//  CountriesExplorerTaskTests
//
//  Created by Marwa Attef on 08/11/2025.
//

import XCTest
import SwiftData

@testable import CountriesExplorerTask

final class CountryModelActorTests: XCTestCase {
    
    var container: ModelContainer!
    var actor: CountryModelActor!
    
    override func setUp() async throws {
        try await super.setUp()
        // Create in-memory container
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: CountryDBModel.self, configurations: config)
        // Pass container directly to actor
        actor = CountryModelActor(modelContainer: container)
    }
    
    override func tearDown() async throws {
        actor = nil
        container = nil
        try await super.tearDown()
    }
    
    func testSaveOrUpdateCountry_InsertsNewCountry() async throws {
        let country = CountryDBModel(name: "Egypt", cca2: "EG")
        try await actor.saveOrUpdateCountry(country)
        
        let all = try await actor.getAllCountries()
        XCTAssertEqual(all.count, 1)
        XCTAssertEqual(all.first?.name, "Egypt")
    }
    
    func testSaveOrUpdateCountry_UpdatesExistingCountry() async throws {
        let country = CountryDBModel(name: "Egypt", cca2: "EG")
        try await actor.saveOrUpdateCountry(country)
        
        let updated = CountryDBModel(name: "Egypt Updated", cca2: "EG")
        try await actor.saveOrUpdateCountry(updated)
        
        let all = try await actor.getAllCountries()
        XCTAssertEqual(all.count, 1)
        XCTAssertEqual(all.first?.name, "Egypt Updated")
    }
    
    func testDeleteCountry_RemovesCountry() async throws {
        let country = CountryDBModel(name: "Egypt", cca2: "EG")
        try await actor.saveOrUpdateCountry(country)
        try await actor.deleteCountry(by: "EG")
        
        let all = try await actor.getAllCountries()
        XCTAssertTrue(all.isEmpty)
    }
    
    func testGetCountry_ReturnsCountry() async throws {
        let country = CountryDBModel(name: "Egypt", cca2: "EG")
        try await actor.saveOrUpdateCountry(country)
        
        let fetched = try await actor.getCountry(by: "EG")
        XCTAssertEqual(fetched.name, "Egypt")
    }
    
    func testGetCountry_ThrowsNotFound() async throws {
        await XCTAssertThrowsErrorAsync(try await actor.getCountry(by: "US")) { error in
            XCTAssertTrue(error is DatabaseError)
        }
    }
}

// Helper for async XCTAssertThrowsError
extension XCTestCase {
    func XCTAssertThrowsErrorAsync<T>(
        _ expression: @autoclosure () async throws -> T,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line,
        _ errorHandler: (Error) -> Void = { _ in }
    ) async {
        do {
            _ = try await expression()
            XCTFail("Expected to throw error", file: file, line: line)
        } catch {
            errorHandler(error)
        }
    }
}
