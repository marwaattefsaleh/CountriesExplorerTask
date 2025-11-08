//
//  GetCountryUseCaseTests.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//
import XCTest
@testable import CountriesExplorerTask

final class GetCountryUseCaseTests: XCTestCase {
    
    var repository: MockCountryRepository!
    var useCase: GetCountryUseCaseProtocol!
    
    override func setUp() {
        super.setUp()
        repository = MockCountryRepository()
        useCase = GetCountryUseCase(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testGetCountry_ReturnsCountry() async throws {
        // Given
        let entity = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG",
                                   population: 100000, region: "Africa", languages: nil, coordinates: nil)
        repository.savedCountries = [entity]
        
        // When
        let result = try await useCase.getCountry(by: "EG")
        
        // Then
        XCTAssertEqual(result.cca2, "EG")
        XCTAssertEqual(result.name, "Egypt")
    }
    
    func testGetCountries_ReturnsAllCountries() async throws {
        // Given
        let entity1 = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG",
                                    population: 100000, region: "Africa", languages: nil, coordinates: nil)
        let entity2 = CountryEntity(name: "France", capitalName: "Paris", flag: nil, currency: nil, cca2: "FR",
                                    population: 67000000, region: "Europe", languages: nil, coordinates: nil)
        repository.savedCountries = [entity1, entity2]
        
        // When
        let result = try await useCase.getCountries()
        
        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.map { $0.cca2 }, ["EG", "FR"])
    }
    
    func testGetDefaultCountryAndSave_SavesFirstCountry() async throws {
        // Given
        let remoteCountry = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG",
                                         population: 100000, region: "Africa", languages: nil, coordinates: nil)
        
        repository.getCountriesResult = [remoteCountry] // <-- Add this property to MockCountryRepository
        repository.savedCountries = []

        // When
        try await useCase.getDefaultCountryAndSave(by: "EG")
        
        // Then
        XCTAssertEqual(repository.savedCountries.count, 1)
        XCTAssertEqual(repository.savedCountries.first?.cca2, "EG")
    }
    
    func testGetDefaultCountryAndSave_DoesNothingIfEmpty() async throws {
        // Given
        repository.getCountriesResult = []
        repository.savedCountries = []
        
        // When
        try await useCase.getDefaultCountryAndSave(by: "XX")
        
        // Then
        XCTAssertEqual(repository.savedCountries.count, 0)
    }
    
    func testGetCountry_PropagatesError() async {
        // Given
        repository.shouldThrow = true
        repository.errorToThrow = NSError(domain: "Test", code: 0)
        
        do {
            // When
            _ = try await useCase.getCountry(by: "EG")
            XCTFail("Expected error")
        } catch {
            // Then
            XCTAssertEqual(error as NSError, repository.errorToThrow as NSError)
        }
    }
}
