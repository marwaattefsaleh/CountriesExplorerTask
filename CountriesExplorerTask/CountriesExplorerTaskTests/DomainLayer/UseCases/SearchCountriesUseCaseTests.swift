//
//  SearchCountriesUseCaseTests.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//
import XCTest
@testable import CountriesExplorerTask

final class SearchCountriesUseCaseTests: XCTestCase {
    
    var repository: MockCountryRepository!
    var useCase: SearchCountriesUseCaseProtocol!
    
    override func setUp() {
        super.setUp()
        repository = MockCountryRepository()
        useCase = SearchCountriesUseCase(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testSearchCountries_ReturnsExpectedResults() async throws {
        // Given
        let country1 = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG")
        let country2 = CountryEntity(name: "France", capitalName: "Paris", flag: nil, currency: nil, cca2: "FR")
        repository.searchResult = [country1, country2] // <-- Add this property in mock
        
        // When
        let results = try await useCase.searchCountries(by: "E")
        
        // Then
        XCTAssertEqual(results.count, 2)
        XCTAssertEqual(results.map { $0.cca2 }, ["EG", "FR"])
    }
    
    func testSaveSelectedCountry_Success() async throws {
        // Given
        repository.savedCountries = []
        let newCountry = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG")
        
        // When
        try await useCase.saveSelectedCountry(newCountry)
        
        // Then
        XCTAssertEqual(repository.savedCountries.count, 1)
        XCTAssertEqual(repository.savedCountries.first?.cca2, "EG")
    }
    
    func testSaveSelectedCountry_ThrowsAlreadyExist() async {
        // Given
        let existing = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG")
        repository.savedCountries = [existing]
        
        // When
        do {
            try await useCase.saveSelectedCountry(existing)
            XCTFail("Expected alreadyExist error")
        } catch let error as ValidationError {
            // Then
            switch error {
            case .alreadyExist:
                break // success
            default:
                XCTFail("Unexpected error: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testSaveSelectedCountry_ThrowsLimitExceeded() async {
        // Given
        let countries = (1...Constants.maxSavedCountrySize).map { i in
            CountryEntity(name: "Country\(i)", capitalName: nil, flag: nil, currency: nil, cca2: "\(i)")
        }
        repository.savedCountries = countries
        let newCountry = CountryEntity(name: "ExtraCountry", capitalName: nil, flag: nil, currency: nil, cca2: "X")
        
        // When
        do {
            try await useCase.saveSelectedCountry(newCountry)
            XCTFail("Expected limitExceeded error")
        } catch let error as ValidationError {
            // Then
            switch error {
            case .limitExceeded(let max):
                XCTAssertEqual(max, Constants.maxSavedCountrySize)
            default:
                XCTFail("Unexpected error: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
