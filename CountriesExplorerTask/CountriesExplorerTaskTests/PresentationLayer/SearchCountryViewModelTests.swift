//
//  SearchCountryViewModelTests.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//

import XCTest
import Combine
@testable import CountriesExplorerTask

@MainActor
final class SearchCountryViewModelTests: XCTestCase {
    
    // MARK: - Mocks
    final class MockSearchCountriesUseCase: SearchCountriesUseCaseProtocol {
        var searchResult: [CountryEntity] = []
        var saveError: Error?
        var searchError: Error?
        var savedCountry: CountryEntity?
        
        func searchCountries(by name: String) async throws -> [CountryEntity] {
            if let error = searchError { throw error }
            return searchResult
        }
        
        func saveSelectedCountry(_ country: CountryEntity) async throws {
            if let error = saveError { throw error }
            savedCountry = country
        }
    }
    
    // MARK: - Properties
    var viewModel: SearchCountryViewModel!
    var useCase: MockSearchCountriesUseCase!
    
    override func setUp() async throws {
        useCase = MockSearchCountriesUseCase()
        viewModel = SearchCountryViewModel(searchCountriesUseCase: useCase)
    }
    
    override func tearDown() async throws {
        viewModel = nil
        useCase = nil
    }
    
    // MARK: - Tests
    
    func testPerformSearchReturnsCountries() async throws {
        // Given
        let country = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG")
        useCase.searchResult = [country]
        
        // When
        let result = try await viewModel.performSearch(query: "E")
        
        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.cca2, "EG")
    }
    func testPerformSearchThrowsError() async {
        // Given
        enum TestError: Error, LocalizedError { case failed; var errorDescription: String? { "failed" } }
        useCase.searchError = TestError.failed
        
        // When / Then
        do {
            _ = try await viewModel.performSearch(query: "E")
            XCTFail("Expected to throw an error, but did not")
        } catch {
            // success: error thrown
            XCTAssertEqual(error.localizedDescription, "failed")
        }
    }
    
    
    
    func testSearchCountriesUpdatesUI() async throws {
        // Given
        let country = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG")
        useCase.searchResult = [country]
        
        // When
        viewModel.searchCountries(query: "E")
        // Wait for the async task inside Task { } to complete
        try await Task.sleep(nanoseconds: 200_000_000) // 0.2s
        
        // Then
        XCTAssertEqual(viewModel.countryEntityList.count, 1)
        XCTAssertFalse(viewModel.showToast)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testSearchCountriesHandlesError() async throws {
        // Given
        enum TestError: Error, LocalizedError { case failed; var errorDescription: String? { "failed" } }
        useCase.searchError = TestError.failed
        
        // When
        viewModel.searchCountries(query: "E")
        try await Task.sleep(nanoseconds: 200_000_000) // wait for Task
        
        // Then
        XCTAssertTrue(viewModel.countryEntityList.isEmpty)
        XCTAssertTrue(viewModel.showToast)
        XCTAssertEqual(viewModel.toastMessage, "failed")
    }
    
    func testPerformSaveCountrySucceeds() async throws {
        // Given
        let country = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG")
        
        // When
        try await viewModel.performSaveCountry(country)
        
        // Then
        XCTAssertEqual(useCase.savedCountry?.cca2, "EG")
    }
    
    func testSaveSelectedCountryUpdatesUIOnError() async {
        // Given
        let country = CountryEntity(name: "Egypt", capitalName: "Cairo", flag: nil, currency: nil, cca2: "EG")
        enum TestError: Error, LocalizedError { case failed; var errorDescription: String? { "failed" } }
        useCase.saveError = TestError.failed
        
        // When
        viewModel.saveSelectedCountry(country)
        
        // Wait for Task to complete
        try? await Task.sleep(nanoseconds: 200_000_000) // 0.2s
        
        // Then
        XCTAssertFalse(viewModel.itemSelected)
        XCTAssertTrue(viewModel.showToast)
        XCTAssertEqual(viewModel.toastMessage, "failed")
    }
}
