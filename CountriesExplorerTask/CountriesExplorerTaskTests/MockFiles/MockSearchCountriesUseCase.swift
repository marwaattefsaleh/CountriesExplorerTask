//
//  MockSearchCountriesUseCase.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//
import Combine
@testable import CountriesExplorerTask

final class MockSearchCountriesUseCase: SearchCountriesUseCaseProtocol {
    var searchResult: [CountryEntity] = []
    var searchError: Error?
    var saveError: Error?  // <— this must be checked
    
    func searchCountries(by name: String) async throws -> [CountryEntity] {
        if let error = searchError { throw error }
        return searchResult
    }
    
    func saveSelectedCountry(_ country: CountryEntity) async throws {
        if let error = saveError { throw error }  // ✅ must throw
    }
}

