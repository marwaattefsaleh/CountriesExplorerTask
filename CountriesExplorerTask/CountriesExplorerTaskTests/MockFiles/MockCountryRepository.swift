//
//  MockCountryRepository.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 08/11/2025.
//
import XCTest
@testable import CountriesExplorerTask

final class MockCountryRepository: CountryRepositoryProtocol {
    // Track saved/deleted countries
    var deletedCode: String?
    var savedCountries: [CountryEntity] = []
    
    // Simulate errors
    var shouldThrow = false
    var errorToThrow: Error = NSError(domain: "Test", code: 0)
    var searchResult: [CountryEntity] = []

    // Support for getCountries(by:) used in getDefaultCountryAndSave
    var getCountriesResult: [CountryEntity] = []
    
    // MARK: - Protocol implementations
    
    func saveCountryLocaly(_ item: CountryEntity) async throws {
        if shouldThrow { throw errorToThrow }
        savedCountries.append(item)
    }
    
    func deleteCountryLocaly(by code: String) async throws {
        if shouldThrow { throw errorToThrow }
        deletedCode = code
    }
    
    func getAllCountriesLocaly() async throws -> [CountryEntity] {
        if shouldThrow { throw errorToThrow }
        return savedCountries
    }
    
    func getCountryLocaly(by cca2: String) async throws -> CountryEntity {
        if shouldThrow { throw errorToThrow }
        guard let country = savedCountries.first(where: { $0.cca2 == cca2 }) else {
            throw NSError(domain: "NotFound", code: 404)
        }
        return country
    }
    
    func getCountries(by cca2: String) async throws -> [CountryEntity] {
        if shouldThrow { throw errorToThrow }
        return getCountriesResult
    }
    
    func searchCountries(by name: String) async throws -> [CountryEntity] {
        if shouldThrow { throw errorToThrow }
        return searchResult
    }

}
