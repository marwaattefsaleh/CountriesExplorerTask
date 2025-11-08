//
//  DeleteCountryUseCaseTests.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//

import XCTest
@testable import CountriesExplorerTask

// MARK: - DeleteCountryUseCase Tests
final class DeleteCountryUseCaseTests: XCTestCase {
    
    var repository: MockCountryRepository!
    var useCase: DeleteCountryUseCaseProtocol!
    
    override func setUp() {
        super.setUp()
        repository = MockCountryRepository()
        useCase = DeleteCountryUseCase(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testDeleteCountry_CallsRepository() async throws {
        // Given
        let cca2 = "EG"
        
        // When
        try await useCase.deleteCountry(by: cca2)
        
        // Then
        XCTAssertEqual(repository.deletedCode, cca2, "Use case should call repository to delete the country")
    }
    
    func testDeleteCountry_PropagatesError() async {
        // Given
        repository.shouldThrow = true
        let cca2 = "EG"
        
        do {
            // When
            try await useCase.deleteCountry(by: cca2)
            XCTFail("Expected error to be thrown")
        } catch {
            // Then
            XCTAssertEqual(error as NSError, repository.errorToThrow as NSError, "Error should be propagated from repository")
        }
    }
}
